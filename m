Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619213A9879;
	Mon, 17 Aug 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992712; cv=none; b=WOo/NwFXfZV3Sry+qhZ+k/FDIvuoI+YC8smXxYD+UpSeg7B125jkSI8w+LjnpgfrhcxapEvJCkycsB4y87r32lrPaOv+/GwdFpg4esJeFJRAPWPumMeS7enbmAi/9gNBn2TXwbMAkD4NZORPU5/EB9FRfk7NblZdZYdJViBfqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992712; c=relaxed/simple;
	bh=261p/DeBpAyQF1el8SnPnh7ho2GfmZRpRR1Wtc323fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROKy1qsMQC9e0AiQ+27t9xUbYHdDczRr7jiD5Hw8OxbJCp04xtqD5bLSPppAl/mPwUJRYgAblIyBY1LOBLmo+aIYiWzxThzcMIGhe/sDeBGrbdWsYmM0LIByPNpZuq7yDrw88s3vZxJi/Q3XomiUNZ1QHtz8/hrWDIwEfA5n6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elKEjTdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elKEjTdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635CC1F000E9;
	Mon, 17 Aug 2026 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786992710;
	bh=GmaLjdPS/A0zeV66ab0EU7MLb8KKncXJ0C5BdXmW+XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elKEjTduH3qqyur+kF0U+eLHFaDIHAxA4s3XrWcu8KV8CRygieleBSrFmyLgkPWcT
	 iqnbAubcyHqYymCoj8nE3z7w1iUFD65XZgc6lgF3/nLHF0A+TgWt558tp6fOcQGL8W
	 72LIvWfLBGOyPuLjsg/tmNdFm0UwS+C6Jd63u480L23jeSIdoAFV84TbaYtv/7M8dY
	 96poqGjT0BkIvHuAzqbQazs/bfs1SstSaotB+CifxvHiaN7t3R0VdxEgTT/pKg07DO
	 vO6HtcAASAVjR+FT1VhAuVBVDp3ykvdq9KoypmZfXbTjLggpSBBC/nhn39jDfB21Rc
	 FhK4Rit9IJFGw==
Date: Mon, 17 Aug 2026 11:51:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: Nicolas Schier <nsc@kernel.org>, Kees Cook <kees@kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Message-ID: <20260817185146.GC1249844@ax162>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
 <an9dBpYEIb4GWhAC@levanger>
 <20260814224550.GA3553101@ax162>
 <CY5PR02MB8991C91E71C153EEF452972FE2D82@CY5PR02MB8991.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR02MB8991C91E71C153EEF452972FE2D82@CY5PR02MB8991.namprd02.prod.outlook.com>

Hi Jaihind,

On Sun, Aug 16, 2026 at 08:11:01AM +0000, Jaihind Yadav wrote:
>   Would it be acceptable to handle this generically for external modules in
>   top-level kbuild (`Makefile`) instead of tying it to kstack_erase? I was
>   thinking about adding:
> 
>     diff --git a/Makefile b/Makefile
>     @@ -1057,6 +1057,10 @@ include $(addprefix $(srctree)/, $(include-y))
>      # Do not add $(call cc-option,...) below this line. When you build the kernel
>      # from the clean source tree, the GCC plugins do not exist at this point.
> 
>     +ifneq ($(KBUILD_EXTMOD),)
>     +KBUILD_CFLAGS += -gno-record-gcc-switches
>     +endif
>     +
>      # Add user supplied CPPFLAGS, AFLAGS, CFLAGS and RUSTFLAGS as the last assignments
> 
>   This would avoid per-module changes and also avoid coupling a generic
>   compiler switch-recording behavior to `CONFIG_GCC_PLUGIN_STACKLEAK`.
> 
>   If this direction looks reasonable, I can send it as an RFC patch for review.

I do find this direction to get more at the heart of the problem but
shouldn't this live in scripts/Makefile.gcc-plugins?

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0e1423b09c2..9b9899580571 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,10 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
+# Disable recording GCC options in debug info when building external modules to
+# avoid leaking absolute host build paths
+gcc-plugin-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
--

Otherwise, this would apply to every external module build, not just
ones that enable GCC plugins.

I defer to Kees on whether this is actually acceptable though.

-- 
Cheers,
Nathan
