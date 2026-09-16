Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBA4E1C8A;
	Wed, 16 Sep 2026 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592038; cv=none; b=F2fEe7hJCN7mwMpNbwqqhEXb1qKXqRJeHoiRldQLMCUWaFBEhnuxG2e4k/ibmk1CIC3RL/pXoJl/6PfctvA5edm5M8eCME4G+vL45GAyZLndwTu3R+YloxRPOoTn9vCl+1fJ4QvuJcJFe7ecr4Gfd1cnq+WhQBxMAbdwObaqnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592038; c=relaxed/simple;
	bh=ybr8EEfRYKagfEoXfgFJtfStYX/0J85WMZhTatFAnKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItR91HkmbV3Te42svwquU4EyquX0NvsP3SFVusSl4dIwpjoW7ny+98tRhLIpLQdPNmFeG/cvReAjtvmw+0ObANnAb/cOFuz43tMtrWtML0nA8h2wPeq/KvnKchI3aCXOX1WFmlLSe0K4itgr5iAv5aKOLgFEtfMgIECWkhaDzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tHz2bB7k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tHz2bB7k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AgevcG6q8F+yBhZ/WwdhBjLXSIrE5M1kcR17kIsM+hI=; b=tHz2bB7k6RYhleCE/sDzPG+yy4
	W7nsA4nwMWasHYpLmbunCVydmLwaItGqcnWmfb5x4J/DMuzPjLN8gNuqWHOyXnGdntv4Fq41PEXsX
	nEUeGE8gCbvCml54ra3rSiZ3NCP5jHAFnfg738wFe5rttd3V0RqVTa3cXcsc+pbX+Pawb/Z++JPZL
	e5n1hglsryn6zGe5hiahpOwowpY6DepDZxlphAJcn0kAYtZOs8hxIQoqU/igjzfyHRDkIeg7HucL6
	hPpICeZk4Q9unF5ZZLdsH5vpXHYuUKT43D1xPUqmvtJLZhy1QRIU02tBI2VNbuIOo5vHrkdcnXtlj
	4llwLkSA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6wdL-0000000A6Z4-1fxe;
	Wed, 16 Sep 2026 20:53:35 +0000
Message-ID: <c4eeba54-e5bf-43e8-8974-dc9552ac6347@infradead.org>
Date: Wed, 16 Sep 2026 13:53:34 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Makefile: Add a testdocs target for the
 documentation unit tests
To: Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 Maximilian Huber <maximilian.huber@tngtech.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Augenstein <luis.augenstein@tngtech.com>,
 Breno Leitao <leitao@debian.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Andrew Jones <andrew.jones@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260916184107.i.183-kees@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260916184107.i.183-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 11:41 AM, Kees Cook wrote:
> tools/unittests/run.py discovers and runs the unit tests there (which
> are primarily documentation tools), but nothing in the build calls it,
> so the tests are only run by whoever remembers that the script is there.

Now if we can just remember that this target is present/available ;)

> Give it a target, next to the other checks that need no Sphinx. The name
> ends in "docs", so it matches the "%docs" pattern already in
> no-dot-config-targets and runs without a configured tree, and it sets
> PYTHONPYCACHEPREFIX as the other Python targets here do, to keep
> __pycache__ directories out of the source tree.
> 
>   $ make testdocs
>   ...
>   Ran 121 tests
> 
> with "make dochelp" listing it between refcheckdocs and cleandocs.
> 
> Tested with GNU Make 4.4.1 and Python 3.14.7, on a tree with no .config,
> where it ran 121 tests and left no __pycache__ behind.
> 
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I debated the naming here, since "tools/unittests/" is such a general
> directory location, but figured I'd start with a target that made the most
> logical sense given what is actually being tested there? I dunno. Maybe
> "make testtools"? But that reads weird.

I'm happy with "make testdocs".

Ran 122 tests in 0.241s

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Makefile               | 2 +-
>  Documentation/Makefile | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 66654fa71655..88557288163d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2002,7 +2002,7 @@ $(help-board-dirs): help-%:
>  # ---------------------------------------------------------------------------
>  DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
>  	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs mandocs \
> -	       htmldocs-redirects
> +	       htmldocs-redirects testdocs
>  
>  PHONY += $(DOC_TARGETS)
>  $(DOC_TARGETS):
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 377a449656c8..ee852afe9bb9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -74,6 +74,10 @@ htmldocs-redirects: $(srctree)/Documentation/.renames.txt
>  refcheckdocs:
>  	$(Q)cd $(srctree); tools/docs/documentation-file-ref-check
>  
> +testdocs:
> +	$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
> +		$(PYTHON3) $(srctree)/tools/unittests/run.py
> +
>  cleandocs:
>  	$(Q)rm -rf $(BUILDDIR)
>  
> @@ -95,6 +99,7 @@ dochelp:
>  	@echo  '                    (will connect to external hosts)'
>  	@echo  '  refcheckdocs    - check for references to non-existing files under'
>  	@echo  '                    Documentation'
> +	@echo  '  testdocs        - run the unit tests of the documentation tools'
>  	@echo  '  cleandocs       - clean all generated files'
>  	@echo
>  	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'

thanks.
-- 
~Randy
