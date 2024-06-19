Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C515380B;
	Wed, 19 Jun 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830229; cv=none; b=nEq2oNoBs/uvOuaHx+fzjVMLqmjCZ6lPpblyAPaOGKO621T98H+hKmCJT4gALixHCw/ibAGPEK9GoN7yzzSkpppSifefnt+gXTYIT3KXrEGIQ7DEO/OmSiYUsJ5R1sGnpknmMPPkaLshTuhIhnGYS7nfT4JM2vTiNpvx71DNea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830229; c=relaxed/simple;
	bh=ltWqJ8/ooJ5rh1SMK/TIFWgXACeCLJaNkaYVzkp2obU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh+PTqyHXk/kRAAECxqQYSecMJ94pQ7N4BFIm8DA3pSr1/4+A1G2XQz/Tn/2ADAsb6kPr2joWU0hQQxykCxNDDyr6ZKQmW/uMfev9CoVY9UR+Hwz90pfjlwZWk1HvrXcOaXicGxV4E0j2aHxxiGi8lrO0HujbW/jU+vS2MOdDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEPl0Fpb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEPl0Fpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ED6C4AF08;
	Wed, 19 Jun 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718830229;
	bh=ltWqJ8/ooJ5rh1SMK/TIFWgXACeCLJaNkaYVzkp2obU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEPl0Fpbj48oFkiJ0d9z59bvdQV3Noh8GHCqyWLUvkr9sMRrun1FYqB594ylgd5zH
	 RIClCdgfD1zYtXl9vhJ3ShhgPusStk0NCFY6NMiAK2OfBDnZpHFGIX7eu8/Usu/gxE
	 oWGveYV2j+0HtFdWTSazSivcdSd2THd5v6e/PpYlhF8uCq/W9eNm3+k394ubK6wqar
	 tUqUvmyPIwAGvQ2/SFySpRIBXo/qHrAgCum+ZI4GZEV7ZRNCi5migWSXSc4U/Lzav2
	 /YUV/JDyto3DT/R8sZnBzYNy8HE8VvV51vKAeyc26h0qTPqA0zz+3gJu1s2PeLWjbV
	 5ZyJB4QjIbRlQ==
Date: Wed, 19 Jun 2024 13:50:28 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, arnd@arndb.de
Cc: linux-hardening@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: mips gcc plugin issues
Message-ID: <202406191343.D361BC137@keescook>
References: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>

On Tue, Jun 18, 2024 at 04:41:01PM -0700, Jeff Johnson wrote:
> I'm trying to do an allmodconfig build for ARCH=mips using:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-mips-linux.tar.gz
> 
> This build dies quickly with:
>   CC      scripts/mod/empty.o
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
> cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
>   CC      scripts/mod/devicetable-offsets.s
> make[2]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
> cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
>   HDRINST usr/include/linux/usb/tmc.h
> make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
> 
> I see the following in my .config:
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
> 
> So I'll turn those off, but just want to flag that this issue exists.
> Seems either the plugins should work or the allmodconfig should turn them off.

Well, the plugins work with all the other compiler versions all the
various CI systems use. :) For example, I don't see this with distro
cross compilers:

$ mipsel-linux-gnu-gcc --version
mipsel-linux-gnu-gcc (Ubuntu 12.3.0-1ubuntu1) 12.3.0

I suspect this is a problem with the kernel.org crosstool builds? I'm
CCing Arnd, who might know more about this.

-Kees

-- 
Kees Cook
