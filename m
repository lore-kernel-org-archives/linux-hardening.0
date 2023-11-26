Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="k/taYEh+"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAB92
	for <linux-hardening@vger.kernel.org>; Sun, 26 Nov 2023 06:48:19 -0800 (PST)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 72Z9ryYJLL9Ag7GQlrUdsj; Sun, 26 Nov 2023 14:48:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7GQirdq4M11XZ7GQjrGNwJ; Sun, 26 Nov 2023 14:48:17 +0000
X-Authority-Analysis: v=2.4 cv=Z+v/oVdA c=1 sm=1 tr=0 ts=65635ab1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=f0Whz4inhACu9W4x6ooA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hr/7m9hoMvRnDst3lNW04H2ADFNUoGwpJyvyjtjjCiw=; b=k/taYEh+v8r6b8Ru5iAQrLIIaz
	KR9OtTQ6TTh4jK0kiz24EHOKxXiWKkARx/ESXAF3ehFRh3egvucQn3MoNe3TGrzJgTsOCe8N9HLf+
	PS9jtbyJMzlXtryibQbpPwZVbMD1pLbt1CZt/H6TFx3NB2hhxI7oUVq/WLenXT8tcPz/lhDA+6sKI
	dX3S05+LaZ1ZI9qs4vELXGyoH7CiivCwLL2sCKrNwh3yFrybW80xz53X94HBCidiAQG8vkrZ+Qg8Q
	1MA8pZNoEkncc7X2o5ePbIBGFckcsGaoe7McJ6MqseZMQrlBZisv0+MFS5Unqmxh0TPsBNDcfuK02
	2Qy1d+Ng==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:42256 helo=[192.168.0.9])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r7GQi-002JlB-0q;
	Sun, 26 Nov 2023 08:48:16 -0600
Message-ID: <b62a458c-dd5e-4e8c-bb2f-f997ae329614@embeddedor.com>
Date: Sun, 26 Nov 2023 08:48:14 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mux: Turn 'mux' into a flexible array in 'struct
 mux_chip'
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Peter Rosin <peda@axentia.se>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r7GQi-002JlB-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.157.122]:42256
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIzKz6I6WMCIRz0dp2MzbXae1nedq+wlWaJPIcCq4HVKhW0CN24l2EqnsL32EkYUswD9Z/thrTSXy2Eb1/Wvw55K+ENuGLDWTFqanX/PwolQHxz+A60L
 1PEwRH1+4kUxpdqWaNvhEyeiYx2+/M3tLRUYBwXfnt91n1looC/bpsx5UgViGDbM7Prd+SiUYc+4447s8YCayoOt8NZDnL6EAmh1qIUrDWl0c0bgBiTiqRqK
X-Spam-Level: *



On 11/26/23 02:08, Christophe JAILLET wrote:
> The 'mux' array stored in 'struct mux_chip' can be changed into a flexible
> array.
> 
> This saves:
>     - a pointer in the structure
>     - an indirection when accessing the array
>     - some pointer arithmetic when computing and storing the address in
>       'mux'
> 
> It is also now possible to use __counted_by() and struct_size() for
> additional safety.
> 
> The address for the 'priv' memory is computed with mux_chip_priv(). It
> should work as good with a flexible array.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The struct_size() goodies only work if sizeof_priv is 0. Adding an
> additional size_add() would make it safe in all cases but would make code
> less readable (IMHO).

Just save struct_size() in another variable, and use size_add() like this:

size_t size = struct_size(..);

.. kzalloc(size_add(size, sizeof_priv), ...);

--
Gustavo

> ---
>   drivers/mux/core.c         | 4 +---
>   include/linux/mux/driver.h | 5 +++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 775816112932..80b2607b083b 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -98,13 +98,11 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>   	if (WARN_ON(!dev || !controllers))
>   		return ERR_PTR(-EINVAL);
>   
> -	mux_chip = kzalloc(sizeof(*mux_chip) +
> -			   controllers * sizeof(*mux_chip->mux) +
> +	mux_chip = kzalloc(struct_size(mux_chip, mux, controllers) +
>   			   sizeof_priv, GFP_KERNEL);
>   	if (!mux_chip)
>   		return ERR_PTR(-ENOMEM);
>   
> -	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
>   	mux_chip->dev.class = &mux_class;
>   	mux_chip->dev.type = &mux_type;
>   	mux_chip->dev.parent = dev;
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..c29e9b7fb17b 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -56,18 +56,19 @@ struct mux_control {
>   /**
>    * struct mux_chip -	Represents a chip holding mux controllers.
>    * @controllers:	Number of mux controllers handled by the chip.
> - * @mux:		Array of mux controllers that are handled.
>    * @dev:		Device structure.
>    * @id:			Used to identify the device internally.
>    * @ops:		Mux controller operations.
> + * @mux:		Array of mux controllers that are handled.
>    */
>   struct mux_chip {
>   	unsigned int controllers;
> -	struct mux_control *mux;
>   	struct device dev;
>   	int id;
>   
>   	const struct mux_control_ops *ops;
> +
> +	struct mux_control mux[] __counted_by(controllers);
>   };
>   
>   #define to_mux_chip(x) container_of((x), struct mux_chip, dev)
