Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F363B4EB0;
	Wed,  9 Sep 2026 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937944; cv=none; b=m710otnOJToljqAS0OICX0+0QvcLCf20sXGe4YeJRsuL4g8WmHzubkXF5/lr+5gQcw3Wxdt0soJ2H6qXEUzdqNFF1Le0ktiDjrAtlVwQ3ezSdb/irgB2KvUhEbFdOakerM2S5KEHN9b0p7dya7omhf0A6V8aAo0F8Qpa1bRv/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937944; c=relaxed/simple;
	bh=2etGyWrpOBp06VNVnIZMJlPFLVQFCFpYV3orDZehrn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUvBecTMaYJUctsLnt8cQ7m8+NqYwrAEuJ11W3toFCqvpX+oldGV2H/kDW9JaESW2V6aODbCFhNyCPzdKlpta9zk81XA/hXR/qYL5eL5gZGvTm6dE/B6XRJxJ775uE1RnbkQiap5B6uD8CmHO/5xjDDzWjRNdQ06ujT6ADDW5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Y5/CSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Y5/CSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4E1F00A3A;
	Wed,  9 Sep 2026 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937942;
	bh=S8lgk+zECgdVWRekWjpYk9ffkv86k+GlTApSPU61bGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3Y5/CSjtBRHQDHs/3yrO6VKdhVDHo4wVqB+1HC+s4n8HuGx2zwafCjcbPVPGV+rK
	 Pb4rEN5eOEHnNHFjDzW+FFhYk6jSfvgKiJ0wjuMb8svVqKmTOs1NWID1QlwRwQPU9I
	 a6kr7wQJ8h0ZFy3xySQ/q2YQ5iGVa8tq2aiE+uN7qMwKEr8jig3g8C84pQ1oDOGS2F
	 7OAMb5Y8K6mlPCLqxUCMDEjktU0O0mNNUAxE8+lu/a2MlXR4wboIgkE0QwphBFgd5j
	 A3uk/iudv5fwbaRPT+ZED+cS2yIaVGAYTZ9M89AdIHabiicPkC2nw7kSrkxo3Z0fxC
	 bry6uMQpbmpog==
Date: Wed, 9 Sep 2026 08:12:17 +0100
From: Simon Horman <horms@kernel.org>
To: James Lee <james@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/7] net: mctp: usblib: Add test for splits
 inside headers
Message-ID: <20260909071217.GG40544@horms.kernel.org>
References: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
 <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>

On Thu, Sep 03, 2026 at 10:42:19AM +0800, James Lee wrote:

...

> +static void mctp_usblib_test_rx_header_splits(struct kunit *test)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct mctp_usblib_rx *rx;
> +	size_t i;

Hi James,

This is a minor problem and it is addressed in the following patch,
by removing the line above, but i is declared yet unused  and should
not be added here.

Flagged by W=1 builds with GCC 16.2.0 and Clang 22.1.8.

> +
> +	ctx = mctp_usblib_test_init(test);
> +	rx = mctp_usblib_test_rx_init(test, true);
> +	dev = ctx->dev;
> +
> +	/* Unrolling here so stack traces point to the invocation with the
> +	 * failing length.
> +	 */
> +	mctp_usblib_test_rx_split_header(test, 1, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 2, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 3, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 4, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 5, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 6, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 7, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
> +}

...
