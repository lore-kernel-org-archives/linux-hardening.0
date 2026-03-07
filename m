Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAB1E4BE;
	Sat,  7 Mar 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868081; cv=none; b=JW5dQ3QyYWKYXl6TYziBYH2pCTwQbnEBM5GeyFaH9GdASf7aCPDe7kvl4pd5/ZZ/SLBKduOZ6qwHaNSPZteEBBtgWb+duKaaUzs5x0Kwc7VDwqkggI8gheqTAQGzSIRIUP3OjoTYYdUizOxFrDJIouHPbHSbB+zcU3eEukXwYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868081; c=relaxed/simple;
	bh=0/xn8MdIKhr57MXLx8zLBFy5kZcEXcsZjH0g4bZhG74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORy1ZbLeAzketJsCfbel296POhVYUigodkVvNImgfYX/8eG8t01/ErlheMAMaR8koNsauNDfgTm5QxjxTZgiJQN7g/YYKzm1UURRXRcvMNjdTXWqln/UeY+3syyXtX6WUgX254wQYmAVdunp67Z2rfJqqzuMNL5HnU6A4rlyPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZZGK/HS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZZGK/HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5061AC19422;
	Sat,  7 Mar 2026 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772868080;
	bh=0/xn8MdIKhr57MXLx8zLBFy5kZcEXcsZjH0g4bZhG74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZZGK/HSOesPcUDn5z1A2mCsDQmhCZujr0sirWAxcwShPlzB0VHXeIkV5zvL4nB5g
	 QsxVvJMVq6S2hOER4wCoSXvegFnEOBNc4vyeK1/FSJANH2/AIzSlj7n82IvqIXS6nY
	 Jn+eruIhgbF99R5CdxkAbrsa1QuX5u4SgbtLGDpg=
Date: Sat, 7 Mar 2026 08:21:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: simplify allocation
Message-ID: <2026030739-uninstall-blustery-a91f@gregkh>
References: <20260306222148.8200-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306222148.8200-1-rosenp@gmail.com>

On Fri, Mar 06, 2026 at 02:21:48PM -0800, Rosen Penev wrote:
> Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> 
> Add __counted_by for extra runtime analysis when requested.
> 
> Shuffle some code in probe to provide a clearer picture.

That's a lot of different things all at once, please do not do that.
Remember, kernel changes need to be "one patch per logical thing".

thanks,

greg k-h
