Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444026;
	b=i1cxoIHUAZjkOX22IUVCMFV4yeBazPpwC9OfTCcd8yhcXgaQIYkLSixY8NEIlRqHqRvf
	 1lYVluLlnu3DfUDkUnaxf3gPVCgy3/ton3CsfnojzZd3QKmxRDNRWw2CEuBU9vPuMXwRL
	 /GVsupLANvFheQNfY8L1wVDBBxccr+GUt/3N8gV4qEv3opkIQZn1J11Ghwu7q7mMlKZvH
	 NyVL2K8zx7bqe1i0fdjm6Hnhz4sIMowYtZUH/nu0aBF8/76aHaTen/AFfDQxTpdogxXLQ
	 mtCDAgNiHwUsd5qFzjY7x1e3ndzx1eiq5Ap97qcbSO1zQuqxxvttJftqkU9rdVncR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444026;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2oJdV17KIZUZasV35CEvbX1/9MgA6Fm/bZE/QeZLfdk=;
	b=OhOJCTdURrZtVmiNpLy8Mvt29H+VzX+RUYHOpkF8LqXUm8vLSTZP+I3BHFOcAt84bQxc
	 JHYyDFLhzf/1/6p2Ga6W+3U/tBUdoeRi/nntj03MQ2gCh8A2maw2xXAiC6MxJb8wA5i1O
	 vOXLOcXxPw0fQYWbtV4iftgFqVjI2SOuPLLLgkQjvlXzyCdWR2zHmM40tAWE20f4uDqBL
	 WqG0EPJtA43uHSXoplCGtfDy3W4A9J43IvvmTeFoTb2ZnBFe7WRaNr92NOgEoaSF+EXb5
	 cZTWuLj71WXGdNkJxuXJ2+PeGiUzI5BEIN3LAAXKp0rqC8anONQAiDoMA7pdS2TxKyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E7YJwu/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E72606A31A;
	Mon, 23 Nov 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7YJwu/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF61B1F000CF;
	Mon, 23 Nov 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444026;
	bh=2oJdV17KIZUZasV35CEvbX1/9MgA6Fm/bZE/QeZLfdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7YJwu/tt5HLoe4Fm1DuHMFT6R/8PllezXlnn2sgTYRc8GbaCMFUtuRDw9aHl2nnf
	 3SmwP+ULPEU655DZfUriz7QR0arv5Wd/dW5inCUGP+cWKf3QejQKHOyfprTeYV55B3
	 jlFlGveLiQoN1/MM4yVQBILuWbEPGsfkN/UiaehYLNHuvVTZMlJrbYY4f7Kw6FABma
	 mdYPsbFnSdvGYBOiFu1FydX73fRdtGRT3+PC5j9LyEBinMJGrZbw3L2OYXx8Qn9XLe
	 8t9ByqBH1hlkoXFH+nAtgIdXCh73I+0P5qXOdD4Npvnri4p+Fkgu9HJbGB2d6y7YKb
	 EnJe1mQ5A3jUw==
Date: Mon, 23 Nov 2026 08:27:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Hans Verkuil <hverkuil@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH v2 05/10] of: property: implement the
 .property_get_names() fwnode operation
Message-ID: <179544402303.2319923.12244969864693220730.robh@kernel.org>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-5-4edc23d5cf50@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-fwnode-for-each-prop-v2-5-4edc23d5cf50@oss.qualcomm.com>


On Fri, 13 Nov 2026 16:47:05 +0100, Bartosz Golaszewski wrote:
> Implement the property_get_names() callback from the fwnode interface
> for OF nodes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

