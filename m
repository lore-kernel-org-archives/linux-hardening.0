Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A11F03D3;
	Tue,  1 Apr 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501401; cv=none; b=eyjLV9TdUOTuwthnaJkicT9mMbftMqqmrzxbocVAfr0nI0uFrqvV8eZ2F63JUFvN7xdL3WG5w19mqDgFlxS07ofityTpLbdufuuoqstvSkTlbWJMRewqFlumH2DYs1Yh3Scsw8FDZtvsjmF8OSmuY8jkDzkUEiLs2FB1S4lqv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501401; c=relaxed/simple;
	bh=r6HPVNbL59phmd4XeurjCVNmO0bQLIsjG0GRIPVMgz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+y93zVepIUWOrNHoyHJQ6NduDgbr2SDoGO38m6lfeu7/Z+3iUno3ihuPu/GwJde7PuAhJtr5Ajlcl/1ySwrJ8seH+v7AI4ONjD2jCXlSFJL0gLcMkV9/oE+klfWsqu8Sz16eZplcz0n7IOBPY659xC+cl4NMXXNbVeHNpxguU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6RiEMRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6RiEMRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A289C4CEE4;
	Tue,  1 Apr 2025 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501401;
	bh=r6HPVNbL59phmd4XeurjCVNmO0bQLIsjG0GRIPVMgz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6RiEMRJh66E8tviabjNtjgJLS16C/DoKsOuFYDSiao+vjhdw5KaCfyOZO7MoI5+j
	 98ark8QP7UGFKtsgO9CvxrIhj3Jirw0Hw2bc0FSQ8iJXC3QI3lI8ldiyuGmqNlyljH
	 Md976ejGpDgyFjY2qoeUt+cVNtFXIThv8Scl4QrNcbYuqis28lVCPJxlYuDrhwkVF0
	 ZDj00qUn8y+59jSCIYdJfv/MtDaOr5w9SOCKwI2GpbFLQA/UKSEklsb+hufibW3LUi
	 l3mh1iV8nk5543oonDaT3VCvopEP61d/JDUmfhYgWYaIKoAVwG94qBqE/ljXOsbZNW
	 Z+KkGBTaqgCuA==
Date: Tue, 1 Apr 2025 09:56:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_kbd_led_backlight: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-u4VshJbamUY9Jb@google.com>
References: <Z-afGnRbyGs4dHb1@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-afGnRbyGs4dHb1@kspp>

On Fri, Mar 28, 2025 at 07:07:38AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/platform/chrome/cros_kbd_led_backlight.c:141:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_kbd_led_backlight.c:162:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

For my reference:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
