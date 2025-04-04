Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F993217730;
	Fri,  4 Apr 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787934; cv=none; b=O4cw9LOdUs7vg5Ijo8JKVPL6XOhEr6IWRncKIwDUoVJv0VFx2iSOa7q/UpdRvVx92NuTAuRg4f1u1A7m5cuAEf14OCiokaws9Rjyh5f/EbMQ6BUYjUuYS87RWPVk3bilbzqo4i+XJOhLk9asvezXDQv9xpW9IPEb5+cqgZXmL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787934; c=relaxed/simple;
	bh=VOGjQIHwLhwyIJ5ZlDAvQ/dlI71wCrXh/f+0ccbPS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgIhbsCWLtDo/gW1HZ1V12QxPIfIs1qYd2j+Qhzyn7C4hXEL6LOKx9xb0LqDP6U6Ab/GGnV/5IQvvJ7tu9ai+n7u24POvaT0wu+HZOTqalajYjcj9gcXNQuKgU18EqwCMgX5PCV8OzOOFZhOkMqp2bk25TYuWPFPPp4y+wvcj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCJEM04W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCJEM04W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEF7C4CEE9;
	Fri,  4 Apr 2025 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743787933;
	bh=VOGjQIHwLhwyIJ5ZlDAvQ/dlI71wCrXh/f+0ccbPS6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCJEM04W6s6U6aev8tqy7foKok11Rr5eZ+UCOlJkccO0Cq7Bnewu89x5xzPkLaA6+
	 NwFpoM4/hYkGhnpr5OaKp/37hTVzBTEi8o2Lu6/XBY3tpga+WJNmUwGYtnMe42QzBL
	 tnFe4DqugYwLHJYsJO6iiActDCEKL8NPHlnegKJkLK6Ld/jM/BgfcZdYwCjy7gJOSe
	 yz6WdHm9zWKTMajQy2K+OmKC8q3Hsv94WuP/mAgNhryUHh/hdMolvMoXLGXgSlOezP
	 LEAt6xeFdu11o90KyP5hOL0hS9EDf920r5K8oMhHKf/SuM3CoYMQ8GLpRrTJB6Buol
	 d/43aPwaH73qA==
Date: Fri, 4 Apr 2025 10:32:10 -0700
From: Kees Cook <kees@kernel.org>
To: Tadhg McDonald-Jensen <tadhgmister@gmail.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: cross compile fails with GCC_PLUGIN_LATENT_ENTROPY
Message-ID: <202504041030.FDB5E355F@keescook>
References: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>

On Tue, Apr 01, 2025 at 05:34:05PM -0400, Tadhg McDonald-Jensen wrote:
> Hello,
> 
> When cross compiling the linux kernel with
> `CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y` it tries to compile the plugin for
> the target platform instead of for the host machine causing the
> compilation to fail.
> 
> I've opened a bug on bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=219973
> 
> Specifically I am using GNU guix and trying to compile with `ARCH=arm`
> and `CROSS_COMPILE=arm-linux-gnueabihf`, in guix the include paths are
> setup in a non typical way so if that is relevant to this error I am
> happy to provide more detail, but hopefully just the output of make
> showing `CC scripts/gcc-plugins/latent_entropy_plugin.o` instead of
> `HOSTCC` like many other files in the scripts folder is sufficient to
> reproduce and solve this issue.

If the kernel's build system can't find the right includes, that would
explain it. I'd check final depends line from scripts/gcc-plugins/Kconfig:

bool "GCC plugins"
        depends on HAVE_GCC_PLUGINS
        depends on CC_IS_GCC
        depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)

Which validates the Makefile's use of that:

GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)


-- 
Kees Cook
