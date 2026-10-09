Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602D4C9E19;
	Fri,  9 Oct 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559373; cv=none; b=gYSi3qQc7XnOqv94bnrIm8MtvU8vBWNLqJU1L87d9X4QZsg8FTRgKpBBHcZxX3kmdoaQ3vMhqqU0NVaysAEZ8YFHNfvPQE8RHy68B+Jy8wcg1PSVVwqkV6qIiAbN2MT57pB23j3L3F8MYPIxqHOH3EKfuaoUFV+w+MedpYZJNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559373; c=relaxed/simple;
	bh=GTQovboIcNR9R/ScPbWLBEgm3nP1UkZmiJO85XmTewY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fjhtzSpK+FcJWQHOg8SKJ+tF6pJQs9sWW81wn5dNb9MkvfnNsh6TNI9QzzhzhhPM+xqFvwHz6A8ZtqBbPyyCXx/R6f7QS5fU71bYM2aYYE1k4M8pvYo1HtAMKyjEdO1g9SFKKR5qebWZKNNjSikDAlf/6WJgjqls+aXVYSJtnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYnHCYZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYnHCYZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F081F000FF;
	Fri,  9 Oct 2026 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559372;
	bh=GX1M42bQqDDZSQDRtAUu5Zivv8JFp+0LgJlH2BZUFXk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nYnHCYZ0sNaBtLQQcRCDsE3J65iTFMqD6OWiuUJsmbP1vRj7HteFD40PuUYd1hb8a
	 VwtZZpz/fIkVpu4k9kd7DFYgn+ochjKne8Tsl0sDf6a9vJxDlJkvxSfcqTq7qOvFZf
	 X9WfmoDcSQhp5sSbQ8aEs4jkJHdMUuQBR4gC3Fwm+jz5nvTBCJPgnEvizwuAPMpVVV
	 fWNMML8uZd6kbYWSZZoH3aS3X4ruW9vQg9A8lCPll9BUh9zPZgDSKi+K9Cbo+KuyqS
	 aeBxLnSX09lZcWxKWsF4bxCB/Qn7BUvxjE9X1I6wRWiEfE28sgMCpcp/YQLdNHAsX6
	 Gpzy7LekF2YSA==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 2/2] kbuild: Mark the initcall ordering recipe as
 recursive
From: Nicolas Schier <nsc@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20261009062733.3119731-2-kees@kernel.org>
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-2-kees@kernel.org>
Date: Fri, 09 Oct 2026 17:20:08 +0200
Message-Id: <179155920867.324725.17951375258235191243.b4-review@b4>
X-Mailer: b4 0.17-dev-fde28
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=GTQovboIcNR9R/ScPbWLBEgm3nP1UkZmiJO85XmTewY=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBqyQYqFIQQe5/qniOD7Rlw7CxUH3+lrC6zZMj0p
 cQ34w/ACs+JAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCaskGKgAKCRAHUgpwFiYS
 aXONEACmdGYim7uibnq49CJrqpJOQSsZJAAeyMTuKqhMCsmQ8Eh8et4IF/N6D05rV64gbR9MBfy
 1XooFqyQzqFqfvvQICO9IjYwt9xOgSuQf58KtqVSfwiqzrNNbkgZr2BTNR9k8SiNjcYhQPpzVUK
 BnRj9kVmiVVQCDg61spbGfDxbLeVI4hxv73BFkmBbwNwXTLBhIAoOnTk1k4ertt1wnmkaN/pMQB
 u7imubmMS7mKbq5GdKnhvKRteH+mwuFmTdQ+Bbd1EPM+FuSW/ro9kq2yITa7IsVBlSAxa/cU3jd
 SXkkIXCR178A7FC/0hPSgGY+dGSrvZjc6X3VZZoD4Iyuqq7wNNgW48X1ASr+i3Z36MahY06dBB7
 JJBLoXuN7OTG9+mnb1AM+I9+cXEwo/zwx6uyeVn+WTv0mxwA7It/Sv/BG815xDxrGtJdDmbSZw4
 6AMbq35PgztGo8+XSOSUCigX+eqVTzmOSc+4u4XaT7M66jpPs4h9fSx9oqM1OhUJY3LAUYbZOqG
 Xy8/wYMjtiRwcIb8nkcFtCbN8u8yMXTVPQVvzLd1IA0EW3z5w0NALNJ7ZfGHRyZkiZeoNnt4nf+
 vFVWt2dax7CQPsmYvWjfZlSAxhjwVLMKmNV+yI+c0xvOtQi+JvLCawCd+4LugfX6sdvNWrbKBGL
 H67nI0D4mSBCJAw==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F

> generate_initcall_order.pl, which orders initcalls for Clang LTO, forks
> a child per input file, up to the job count scripts/jobserver-exec
> passes it in PARALLELISM. It used to run from link-vmlinux.sh, which
> the top-level Makefile invokes as a recursive recipe, but
> commit 5d45950dfbb15 ("kbuild: move vmlinux.o link to
> scripts/Makefile.vmlinux_o") moved it into a recipe without "+".
> 
> GNU Make passes the jobserver pipe only to recipes it treats as
> recursive, and the make 4.3 in CentOS Stream 9 also hides it in
> sub-makes (a backport of the fix for GNU Make bug 58232), so
> jobserver-exec cannot open it and prints:
> 
>   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> 
> PARALLELISM is then left unset, and the script caps its children at the
> number of online CPUs instead of the free job slots.
> 
> Mark the recipe as recursive again.
> 
> Tested ARCH=x86_64 defconfig with CONFIG_LTO_CLANG_THIN=y, LLVM=1
> (Clang 24.0.0git), and GNU Make 4.3 plus CentOS Stream 9's
> make-4.3-cloexec.patch.
> 
> Fixes: 5d45950dfbb15 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 24a3a4fd271c..0b37bd5dc3a4 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
>  
>  .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
>  		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> -	$(call if_changed,gen_initcalls_lds)
> +	+$(call if_changed,gen_initcalls_lds)

b4 hinted me on [1], where a similar fix was rejected; but as we know
have more arguments to generate_initcall_order.pl
($(KBUILD_VMLINUX_LIBS)), the situation is slightly different.

Thanks!

Reviewed-by: Nicolas Schier <n.schier@fritz.com>


[1]: https://lore.kernel.org/all/CAK7LNARCM=rUm8mA8GRQ7ufeyfneGf4OEvHmESKt=zuxs2KrHw@mail.gmail.com/

-- 
Nicolas

