Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F246E00C;
	Wed, 12 Aug 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553336; cv=none; b=lxaNkbDygjmKal4co0gdCTmjn1AT0+8teqTPPi/bl+7Vn4/FuYaB6WQC6KU7jrSx83t0iTg36VCbC3Y4j2HzrWHyF+5bn6MC3bRZv8KXF85gL5GSkqWmpEzPy/E7X7Cz+3AQr980j3C6Bn/lXKuU5zoyaVDZbBbTVEDwwoIw4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553336; c=relaxed/simple;
	bh=QwjhAqTt3dEveZCzlOocb+v/HtmO1PeTWsEkY6OVfAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9INHg3Zojk+DNmXWCo4m30XSfH6oPrl6Xb6nbEw85vV+zJbcrDIcbfTXjnJlkxYXMKCVA6if9qZsa5JUsBr1hEGahiFbsomk1pESkwKU46rKAkeR+vD+iDtk7jqP1Eh1qqpS4Gd+jv499O7oaKI7d3MYlYWixzUv0KTYMLaSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZP52QaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZP52QaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997391F000E9;
	Wed, 12 Aug 2026 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553334;
	bh=I1Tk7m6Wylnvrzyr+XDUWzqimWzftfVph1WXIEMhmN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iZP52QaIyhwOYrDoZNhoDM/qB+oFahA2Fm2kbQLM3ue4F5hvPhwKZivOE4lYZB2ah
	 4De/2qmlGa4hEPwO9/LGQaY5Ay92fotdaGLlucCz0DQ19/5i7h9BZkJsIC8hBJyfOJ
	 5ZcrcQ9rwy7+2SCu+pXF6G6QfE3SaHl9H27aCUhduht7wwylqZ5d5dElkL2rgYpH48
	 KDVEz1k+Ash66vT7rQ9DN2M4RBa5aBurRVgkQNnh0X9uVeOunO1eFwBOi+SWiOz0Bm
	 EQEovgpHb452NSMtT5EPRlzTg6iZrkTJxCn5n2FnZPKZoz+JKoCmy9AtLq5+fvpzuT
	 U1hriMfMAHiTw==
Date: Wed, 12 Aug 2026 09:48:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: Nicolas Schier <nsc@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Message-ID: <20260812164850.GA104682@ax162>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
 <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
 <BN0PR02MB8128563CD267288E68943157E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <BN0PR02MB81287EC4BD8A7C0D7E6B5E31E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <amPIsTxtNPhbDU-z@levanger>
 <20260803181217.GB1067866@ax162>
 <CY5PR02MB89911C30B7E51FE706061818E2DC2@CY5PR02MB8991.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR02MB89911C30B7E51FE706061818E2DC2@CY5PR02MB8991.namprd02.prod.outlook.com>

On Wed, Aug 12, 2026 at 10:55:38AM +0000, Jaihind Yadav wrote:
> Hi Nathan And Nicolas ,
> 
> Thanks for the feedback.
> 
> I took another look at this and experimented with a different approach for external modules:
> 
> diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
> index ee7e4ef7b892..xxxxxxxxxxxx 100644
> --- a/scripts/Makefile.kstack_erase
> +++ b/scripts/Makefile.kstack_erase
> @@ -5,6 +5,10 @@ kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
>  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
>  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
>  kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
> +ifneq ($(KBUILD_EXTMOD),)
> +# Avoid embedding absolute -fplugin paths into external module DWARF metadata.
> +kstack-erase-cflags-y += -gno-record-gcc-switches
> +endif
>  DISABLE_KSTACK_ERASE := -fplugin-arg-stackleak_plugin-disable
>  endif
> 
> In my testing, this prevents the absolute stackleak plugin path specified via
> 
>     -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> 
> from being recorded in the DWARF information of out-of-tree modules, while avoiding the use of platform-specific utilities such as realpath/readlink --relative-to.
> 
> I agree this does not solve the broader issue for all GCC plugins, but it appears to address the specific KSTACK_ERASE case that originally motivated the discussion.
> 
> Would this direction be more acceptable than the previous relative-path approach, or would suppressing GCC switch recording for external modules be considered undesirable from a debugging-information perspective?

This seems more reasonable to me. You could save a couple of lines by
making it

  kstack-erase-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches

but I guess that is personal style. I doubt it would hamper debugging to
have this done unconditionally but we could always revisit it if someone
complains.

-- 
Cheers,
Nathan
