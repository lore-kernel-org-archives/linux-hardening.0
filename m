Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C64963CF;
	Thu, 13 Aug 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639387; cv=none; b=WcpRqN8PF3Rnzu9dr7n1/FkzGyrahaS/Gj23pymo7dukIjYP+0iTWzKqZEFkEbYUvdTWTdR+3dfW/YFVsAB4OWELFBJCbKU5SnMmfUWIvwSRYj+ZYN85n5rdISj7d6cN3MQdkgi+OJCIXM+FiP4DqsEdptvwtHAxyd5RYkOPRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639387; c=relaxed/simple;
	bh=18XYJsZ65BgnVlq3F1zRXJLD6La2O92czJ3L6N1Pe+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e45cEs0an5x6vmaBiwn99Cb3wDhk9+4kS7i5l3T2A/l3L/t9CX7bDGQ+ygQmbfIHyGW2UhiyWj33k4oaGas4CTruY4DKUYDlxF5RNLr4YSHYCTeQS9jst9bMEdZoTBZ9dA6XltiUa/bRFucbRz5yZfYbIzpDpXh/Ey/x3aTidH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3/j8n7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3/j8n7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E71F000E9;
	Thu, 13 Aug 2026 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639362;
	bh=oF5DTKYd+ENE8uJqw+dkx2LAUHD3P6ue7t8VnUrsAXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V3/j8n7qqdIchKZjZ8UHxgY/RkOdJSCQxrcTPT3TrRj8GgpWWhpFpblO2M6PAVijO
	 VmNu76ekWMTNjVHRzPr/wtMedGuM/ynS5Bc6QSDq/4v00+So6Q/1J8YAeRFwyjzETo
	 SO3N9PDkyng+RBFJHFUXs4jSUD9w8EJRGWx2DzF5MyXi4gBO7aY4PT0XT1i7t1156L
	 UcGbjSuLYjmFc9YeudfqB0/EYIPwvA4XGLMI6BVUqiOqufrcfvr7pLlbcF+ljcYa1Y
	 6CvzOqQoZg5fZ8QosKOO5lBRPAAg7ucCBr/SFV4q7cfFEfTnbaThG6suO+ep1mRtOe
	 FqjVHS64wmuLA==
Date: Thu, 13 Aug 2026 09:42:42 -0700
From: Kees Cook <kees@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: nathan@kernel.org, nsc@kernel.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Message-ID: <202608130942.4FFA5AAB9D@keescook>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>

On Thu, Aug 13, 2026 at 01:59:49PM +0530, Jaihind Yadav wrote:
> With CONFIG_GCC_PLUGIN_STACKLEAK=y, kstack erase adds:
> 
>   -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> 
> For KBUILD_EXTMOD builds, recording gcc switches can embed this host/build
> specific plugin path into module DWARF producer strings, which trips QA
> checks looking for absolute path leakage.

Isn't this a problem for all Linux gcc plugins, though?

-Kees

> 
> Disable gcc switch recording only for external modules by adding
> -gno-record-gcc-switches to kstack-erase-cflags when KBUILD_EXTMOD is set.
> 
> This keeps stackleak plugin instrumentation enabled while avoiding leakage
> of host-specific paths in external module debug metadata.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/20260803181217.GB1067866@ax162/
> Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> ---
>  scripts/Makefile.kstack_erase | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
> index ee7e4ef7b892..6f31a3915d24 100644
> --- a/scripts/Makefile.kstack_erase
> +++ b/scripts/Makefile.kstack_erase
> @@ -5,6 +5,7 @@ kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugi
>  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
>  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
>  kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
> +kstack-erase-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches
>  DISABLE_KSTACK_ERASE := -fplugin-arg-stackleak_plugin-disable
>  endif
>  
> -- 
> 2.43.0
> 
> 

-- 
Kees Cook
