%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

module Default = {
  @react.component
  let make = () => {
    <div>
      <h1>{React.string("Hello, world!")}</h1>
      <p>{React.string("This is a simple example of a React component.")}</p>
      <p>
        {React.string("For more info, see ")}
        <a href="https://reactjs.org" target="_blank">
          {React.string("https://reactjs.org")}
        </a>
      </p>
    </div>
  }
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"about"} => <About />
	| list{"exercises"} => <Exercises />
  | list{} => <Default />
  | _ => <div> {React.string("404")} </div>
  }
}
