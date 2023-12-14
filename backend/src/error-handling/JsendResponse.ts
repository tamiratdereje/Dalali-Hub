/**
 *
 *
 * @export
 * @class JSendResponse
 */
export class JSendResponse {
  status: string;
  data: any;
  message: string;
  stack: any;
/**
 * Creates an instance of JSendResponse.
 * @memberof JSendResponse
 */
constructor() {
    this.status = "success";
    this.data = undefined;
    this.message = "";
    this.stack = undefined;
  }
/**
 *
 *
 * @param {*} data
 * @param {string} [message="Request successful"]
 * @return {*} 
 * @memberof JSendResponse
 */
success(data: any, message = "Request successful") {
    this.status = "success";
    this.data = data;
    this.message = message;
    return this;
  }
/**
 *
 *
 * @param {*} data
 * @param {number} nextPage
 * @param {number} count
 * @param {string} [message="Request successful"]
 * @return {*}  {JSendResponse}
 * @memberof JSendResponse
 */
successPaginated(data: any, nextPage: number, count: number, message = "Request successful") : JSendResponse {
    this.status = "success";
    this.data = data;
    this.data.nextPage = nextPage;
    this.data.count = count;
    this.message = message;
    return this;
  }

/**
 *
 *
 * @param {string} [message="Request error"]
 * @param {*} [stack=undefined]
 * @return {*} 
 * @memberof JSendResponse
 */
error(message = "Request error", stack: any = undefined) {
    this.status = "error";
    this.message = message;
    this.stack = stack;
    return this;
  }
/**
 *
 *
 * @param {string} [message="Request failed"]
 * @return {*} 
 * @memberof JSendResponse
 */
fail(message = "Request failed") {
    this.status = "fail";
    this.message = message;
    return this;
  }
}
