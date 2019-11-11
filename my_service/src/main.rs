use rouille::Request;
use rouille::Response;

fn main() {
    rouille::start_server("[::]:8080", move |_request| {
        Response::text("hello world")
    });
}
