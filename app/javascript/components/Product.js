import React from "react"
import PropTypes from "prop-types"
class Product extends React.Component {
  render () {
    return (
    <div className="productlist">
  <h3>{this.props.greeting}! </h3>
      <p>Total Count : {this.props.count}</p>
      	<table className="table table-hover table-bordered table-striped">
      		<thead>
            <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Category</th>
            <th>Stock</th>
            <th>Description</th>
            <th>COD</th>
            <th>Date</th>
            </tr>
          </thead>
      		<tbody>
            <tr>
            <td>Pen</td>
            <td>10</td>
            <td>Pen</td>
            <td>10</td>
            <td>It is point pen</td>
            <td>Yes</td>
            <td>20/10/2019</td>
            </tr>
            <tr>
            <td>Pen</td>
            <td>10</td>
            <td>Pen</td>
            <td>10</td>
            <td>It is point pen</td>
            <td>Yes</td>
            <td>20/10/2019</td>
            </tr>
            <tr>
            <td>Pen</td>
            <td>10</td>
            <td>Pen</td>
            <td>10</td>
            <td>It is point pen</td>
            <td>Yes</td>
            <td>20/10/2019</td>
            </tr>
            <tr>
            <td>Pen</td>
            <td>10</td>
            <td>Pen</td>
            <td>10</td>
            <td>It is point pen</td>
            <td>Yes</td>
            <td>20/10/2019</td>
            </tr>
            <tr>
            <td>Pen</td>
            <td>10</td>
            <td>Pen</td>
            <td>10</td>
            <td>It is point pen</td>
            <td>Yes</td>
            <td>20/10/2019</td>
            </tr>
          </tbody>
      	</table>
    </div>
    );
  }
}

Product.propTypes = {
  greeting: PropTypes.string
};
export default Product
