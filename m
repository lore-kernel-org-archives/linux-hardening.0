Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413C253B5E;
	Wed, 21 May 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825154; cv=none; b=dLENtx0ekZA+E/88OUz9IDYfSR8Wa7FopBEvIg/7TcPideILwiyB3DoeVhzeqDM4xTIQL+EEPHkF3Ev9VwW4+cMl6AL7rlbxayPcyO63AJAB3N59W6XR5AKyaGBcoONVpAX/+I/xBB1ISM0JU1YNxi5cvSinmbz5+6Oh1FtdnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825154; c=relaxed/simple;
	bh=OAPtjhvGq2rqLYOSN3p3U2UsnP7gFs9SLcjeVDkoB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPalB9NUrUGm6e8N8UpuLsrokSuPsbpv9uMwJNmw/BA2TR/+kWvNK61U991PbO1QNn6+Lml4Xq6ni8UTyFboijnwP7XJ9qkvgP25hGCYRXPVwBH0H6fXttshdAZmFzsfs5xuHtPhkWH+88hBao5khCcWql/9UNiZG+d8Aj9Ye70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3RALjd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3RALjd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B4DC4CEED;
	Wed, 21 May 2025 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747825153;
	bh=OAPtjhvGq2rqLYOSN3p3U2UsnP7gFs9SLcjeVDkoB/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3RALjd4MZ6xII4SHpXnUz/mbl1P+P6a6UUibxCyRdMuN5yZqkZnZutqsVGCAv/vR
	 nJOjQYrs76Y0llc6g+8rpiOrob2kXzWXVODvK7ubB9ghsPmVrp7c87WE3Ksi+iqj57
	 kruH+X8BD4pV87/VXXNqrWPrOrHyIdD4mgdduJwo=
Date: Wed, 21 May 2025 12:59:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: adutux: replace kmalloc() with kmalloc_array()
Message-ID: <2025052111-able-unfocused-cdcf@gregkh>
References: <20250503-adutux_kmalloc_array-v1-1-80c74c4bd3e7@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503-adutux_kmalloc_array-v1-1-80c74c4bd3e7@ethancedwards.com>

On Sat, May 03, 2025 at 04:43:21PM -0400, Ethan Carter Edwards wrote:
> Replace kmalloc with internal multiplication with kmalloc_array to
> improve code readability and prevent potential overflows.

But this is not an array of a structure size.

> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/usb/misc/adutux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
> index ed6a19254d2ff9fead898adad0b3996822e10167..000a3ade743258f381d85397395a43c28a8481cc 100644
> --- a/drivers/usb/misc/adutux.c
> +++ b/drivers/usb/misc/adutux.c
> @@ -680,7 +680,7 @@ static int adu_probe(struct usb_interface *interface,
>  	in_end_size = usb_endpoint_maxp(dev->interrupt_in_endpoint);
>  	out_end_size = usb_endpoint_maxp(dev->interrupt_out_endpoint);
>  
> -	dev->read_buffer_primary = kmalloc((4 * in_end_size), GFP_KERNEL);
> +	dev->read_buffer_primary = kmalloc_array(4, in_end_size, GFP_KERNEL);

This is a buffer and you need the size to be correct based on the
commands, right?  It's not an array of a structure, but rather a stream
of bytes.


>  	if (!dev->read_buffer_primary)
>  		goto error;
>  
> @@ -690,7 +690,7 @@ static int adu_probe(struct usb_interface *interface,
>  	memset(dev->read_buffer_primary + (2 * in_end_size), 'c', in_end_size);
>  	memset(dev->read_buffer_primary + (3 * in_end_size), 'd', in_end_size);
>  
> -	dev->read_buffer_secondary = kmalloc((4 * in_end_size), GFP_KERNEL);
> +	dev->read_buffer_secondary = kmalloc_array(4, in_end_size, GFP_KERNEL);

Same here.

I think the original code is just fine as there's no bug here or way it
can overflow, right?

thanks,

greg k-h
