Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDDE566;
	Mon,  2 Oct 2023 11:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40348C433C7;
	Mon,  2 Oct 2023 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696246924;
	bh=d8FcFb3yWGd/9wtt0mcVGwPft2o/vm/EglUHKzdkfgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPG0RdMpsRSEdUD24LYEMhEURsA7sqlGX29fJ5XEfM0gmq3NlvgvkoV7tHor+LC0x
	 uWR04f5dKQExuM5HEQ8X5EPbFKBAW20JvqzSgDBiJ/Ig8a1xMp3Y6jXJhmXXKIzutf
	 iWGdjOIB2dSKGH3qUVJmpIaSboNgAp0rqLbeEFmA=
Date: Mon, 2 Oct 2023 13:42:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: Annotate struct urb_priv with __counted_by
Message-ID: <2023100246-stem-overcoat-c4b8@gregkh>
References: <20230915195812.never.371-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915195812.never.371-kees@kernel.org>

On Fri, Sep 15, 2023 at 12:58:16PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct urb_priv.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/host/ohci.h | 2 +-
>  drivers/usb/host/xhci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks for taking these changes through your tree, I was too slow...

greg k-h
