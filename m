Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF717B50F;
	Mon, 23 Jun 2025 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646477; cv=none; b=XGUcMjTkJWxkhVeAXO+adVwfY9O+l+/GUU0385cUjy7m8TCx9i6q0F2ffQXwWHZymflCM64X7sNkVoRw8o50RTGtZIe5o/xpxj2e3if6+yMMWw471dvFyc8cJecuM41i4l4y+XwI8iV7jvqK01R/+8QhXCMbE0FO4k82DKmyCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646477; c=relaxed/simple;
	bh=F/p19n4jLKY8qfhLjIcgmFNnjbr3UiWnWeJt74VC6PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrQg6LHAU2W4JBnyo55kBUqqxL4TVeyfRaaQSIRjOWKOzg9cQf7cCg5eKVOWHA2fVh2UpwD4/DgG/Z+Vv2/rGPzot9S8HmgFVQU4vvgsq8j6KdwqnX0R/ei1CCWHrPYU7Cqt83mrzcXjpsR7e3yN8Yxh+bPN/pGbzrzM7Fgy1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfZILZnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfZILZnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF59C4CEE3;
	Mon, 23 Jun 2025 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646476;
	bh=F/p19n4jLKY8qfhLjIcgmFNnjbr3UiWnWeJt74VC6PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfZILZncFTKlZIdxlCjsl0YN9JvbigUvsYNv6bOo87ZPA9P9kP3O5RT7itsy4n8uT
	 PlfxcGmM+Nrto6R+9CFnmd4lP/F7pDeuLSl4VKA334ZamtWFTREvFDvdaC7EqKxpNf
	 USqVCykkddNystBC9+WXPo2btItAL4vjR6iqoLNauvtzyplD9fCPIlb7mAul+/Yoq2
	 vXXxTLiJ8+sBv2zWkS1KFUsNT00e+r1OQMAt98mm7e8RPwOu6AvSCktkIv2y3618OG
	 lErr67GtP506lnPLP3UQL5LP1XJqjG9VRWX6+Zi0QNHXGp7xpdWELnZOUQRnK6542y
	 JyMasNFfenWew==
Date: Mon, 23 Jun 2025 02:41:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Naoya Tezuka <naoyatezuka@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] platform/chrome: chromeos_pstore: Add ecc_size module
 parameter
Message-ID: <aFi-yZ0Y_pxKLRe_@google.com>
References: <20250620062822.1018798-1-naoyatezuka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620062822.1018798-1-naoyatezuka@chromium.org>

On Fri, Jun 20, 2025 at 03:28:22PM +0900, Naoya Tezuka wrote:
> On ChromiumOS devices, the `ecc_size` is set to 0 (check dmesg | grep ecc 
> to see `ecc: 0`): this disables ECC for ramoops region, even when 
> `ramoops.ecc=1` is given to kernel command line parameter.
> 
> Introduce `ecc_size` module parameter to provide an method to turn on ECC
> for ramoops and set different values of ecc_size per devices.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: chromeos_pstore: Add ecc_size module parameter
      commit: 545daf90910ec83e167cf3fbcc31fcf5467432b8

Thanks!
