Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726C215077;
	Wed, 18 Jun 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281684; cv=none; b=ssxf5qgwC92fcynYKgWAGPjj0eDYRT32OVTHBpfyFZZF7eaHqXZv00VmsWd7CXW+6LzWlZp5MMdUNTNSTnYm3VbiPcAy/cGErO90GfkTXMxyMPT9eq24MjEVtcNnSEFilanoG2oHqTqEagCSW83sJizQiP/214i5PSHIWSvbIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281684; c=relaxed/simple;
	bh=W2qCaLbLrzw5iXSFwbU8t/i5VVdV/ifM6YljafRDdNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieSIwrVhurhH/WWjk0WqEB4S+Gb0BhQ/Al9Z+1r2X5tgkriqtUqclrSA/lSIaPkSQulu6c3YMBg76QEOEHcLtd8UpuGFzc2gvo/pFuK4vt6qmJSVPP2Kzor8nsC0pS2zyxirbj/cu/k4Rqubh22u1DxK7mCx8L88CFAiD9BL/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvyI5ehK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvyI5ehK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D207EC4CEE7;
	Wed, 18 Jun 2025 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281683;
	bh=W2qCaLbLrzw5iXSFwbU8t/i5VVdV/ifM6YljafRDdNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvyI5ehKproYSJoF4mNCOnBMVpQjDO2/rtidzskORUQHpjGLHlE0/RjTloRBVUz/x
	 fZ+LKy4xIw1eu3Tq+7qzLPPnsdS/tZDqx86QyHdHVUqk8aK2b0r9R9wHlWaeATCXz0
	 K2qyy/aR3fwp4GyTVq8rJgXVfbEO3SC8hq2Ix7uF/nxGf9Ki/QmXRvivv8IqjEyyEW
	 0kSWsGPJwGDSVkFqBmp6YC6iwZv7CMrZ5y5bA3qqEaRaAdawOZnkYAiFl/OAye5Jaf
	 vfW0fdNEAtRR8TlxT6pfW6ZsLEK9Ghdt1L2+5Z9m1d1Ag8UWWnIPAB6chA38E2L3uZ
	 430fewKvGb7Bw==
From: Kees Cook <kees@kernel.org>
To: Peter Rosin <peda@axentia.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] mux: Convert mux_control_ops to a flex array member in mux_chip
Date: Wed, 18 Jun 2025 14:21:20 -0700
Message-Id: <175028167750.3187549.3330233881854530836.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610104106.1948-2-thorsten.blum@linux.dev>
References: <20250610104106.1948-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 12:40:59 +0200, Thorsten Blum wrote:
> Convert mux_control_ops to a flexible array member at the end of the
> mux_chip struct and add the __counted_by() compiler attribute to
> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for a new
> mux chip and to remove the following Coccinelle/coccicheck warning:
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] mux: Convert mux_control_ops to a flex array member in mux_chip
      https://git.kernel.org/kees/c/4bfbc2691de8

Take care,

-- 
Kees Cook

