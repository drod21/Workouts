
module Exercise = {
  type step = {
    id: string,
    description: string,
    duration: int,
    image: string,
    position: int,
    step_type: string,
    video: string,
    tips: string,
    equipment: array<string>,
    muscles: array<string>,
    muscle_groups: array<string>,
  }
  type exercise = {
    id: string,
    name: string,
    description: string,
    image: string,
    video: string,
    duration: int,
    difficulty: int,
    muscles: array<string>,
    equipment: array<string>,
    muscle_groups: array<string>,
    steps: array<step>,
  }

  type apiResponse = {
    results: Js.Nullable.t<array<exercise>>,
  }

	type error =
	| Empty
	| NetworkError
	| Timeout

	let mapError = error => {
		switch error {
		| #NetworkRequestFailed => NetworkError
		| #Timeout => Timeout
		}
	}

	type responseFromApi = {
		results: array<exercise>
	}

	let emptyToError = ({ Request.response: res }) => {
		switch res {
		| None => Error(Empty)
		| Some(results) =>
				Ok(results.results)
		}
	}

	let reqApi = (~url, ~responseType) => {
		Request.make(~url, ~responseType, ())
			-> Future.mapError(~propagateCancel = true, mapError)
			-> Future.mapResult(~propagateCancel = true, emptyToError)
	}

}
exception FailedRequest(string)

type action =
	| AddExercises(array<Exercise.exercise>)
	| None

type state = {
	exercises: array<Exercise.exercise>
}

let reducer = (state, action) =>
	switch action {
		| AddExercises(exercises) =>
			{ exercises: exercises }
		| None => state
	}

let initialState = { exercises: [] }

@react.component
let make = () => {
	let (state, dispatch) = React.useReducer(reducer, initialState)

	React.useEffect1(() => {
		let baseUrl: string = "https://wger.de/api/v2"
		let exerciseEndpoint: string = baseUrl ++ "/exercise"
		Exercise.reqApi(~url=exerciseEndpoint, ~responseType=(JsonAsAny: Request.responseType<Exercise.responseFromApi>))
		-> Future.get((x) => {
			switch x {
			| Ok(results) => dispatch(AddExercises(results))
			| _ => dispatch(AddExercises([]))
			}
		})
		None
	}, [dispatch])

	<ol>
		{React.array(Belt.Array.map(state.exercises, exercise => {
			<li>
				<p>{React.string(exercise.name)}</p>
				<p dangerouslySetInnerHTML={{ "__html": exercise.description }} />
			</li>
		}))}
	</ol>
}


