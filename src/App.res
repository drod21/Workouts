%%raw(`import './App.css';`)
%%raw(`import {make as About} from './About.bs';`)

@module("./logo.svg") external logo: string = "default"

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
    | list{"about"} => <About />
    | list{} =>
      <div>
        <h1>{React.string("Hello, world!")}</h1>
        <p>{React.string("This is a simple example of a React component.")}</p>
        <p>
          {React.string("For more info, see ")}
          <a href="https://reactjs.org" target="_blank">{React.string("https://reactjs.org")}</a>
        </p>
      </div>
    | _ => <div>{React.string("404")}</div>
  }


}
