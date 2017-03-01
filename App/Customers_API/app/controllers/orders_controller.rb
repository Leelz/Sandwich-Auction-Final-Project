class OrdersController < ApplicationController

  def index
    orders = Order.all
    render :json => orders.as_json(
    {
      include: {
        orderedsandwiches: {
          include: {
            sandwich:{ 
              include: {
                bread:{
                  only: [:name]
                  },
                  fillingchoices: {
                    include: {
                      filling: {
                        only: [:filling]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      )
  end

  def show
    order = Order.find(params[:id])
    render :json => order.as_json(
    {
          include: {
            orderedsandwiches: {
              include: {
                sandwich:{ 
                  include: {
                    bread:{
                      only: [:name]
                      },
                      fillingchoices: {
                        include: {
                          filling: {
                            only: [:filling]
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          )
  end

  def create
    bread = order_params["bread"]
    order = order_params["date"]
    filling = order_params["filling"]

    order = Order.create({date: order})
    bread = Bread.create({name: bread})

    sandwich = {bread_id: bread.id, price: order_params["price"], quantity: order_params["quantity"]}
    sandwich = Sandwich.create(sandwich)
    filling = Filling.create({filling: filling})

    Orderedsandwich.create({order_id: order.id, sandwich_id: sandwich.id})
    Fillingchoice.create({filling_id: filling.id, sandwich_id: sandwich.id})

    render :json => order
  end

  private
  def order_params
    params.require(:order).permit(:bread, :filling, :price, :quantity, :date) #create new :sandwich?
    # params.require(:bread).permit(:name)
    # params.require(:sandwich).permit(:price, :quantity)
    # params.require(:filling).permit(:filling)
  end

end