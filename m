Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28682C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  9 Oct 2022 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJISWB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 9 Oct 2022 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJISVz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 9 Oct 2022 14:21:55 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30621CB24
        for <linux-hardening@vger.kernel.org>; Sun,  9 Oct 2022 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YonUpqGZOJje7hx/SBhREMoYVI43XAq5A+lwdyKuzJA=;
  b=bnisDE9kna97VhpkrXFG7dwbJpIjSzQh0XLdEFKBGTx05M0qaCLabNCS
   uB4aUxKtjNuZB5XGiTT1K1NB6yESC0ANnKZREAnKghlHD2AVJ2ujtxsb9
   6nJ9kNsPCVs4jJexrhL0wb8g2V7EXxbefg8OZkPhJPtiyDLMM9ymtFGiT
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25894957"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:21:50 +0200
Date:   Sun, 9 Oct 2022 20:21:49 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     cocci@inria.fr, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] python: Add make_expr and include_match documentation
In-Reply-To: <20221009181603.3242176-1-keescook@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2210092021390.21609@hadrien>
References: <20221009181603.3242176-1-keescook@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Sun, 9 Oct 2022, Kees Cook wrote:

> Add the 'make_expr' and 'include_match' helpers in the Python
> documentation. Additionally cleans up a markdown-breaking line split.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks!

julia

> ---
>  python/python_documentation.md | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/python/python_documentation.md b/python/python_documentation.md
> index d0194d6c1391..1d933b9a3934 100644
> --- a/python/python_documentation.md
> +++ b/python/python_documentation.md
> @@ -11,13 +11,20 @@ file at the end of the execution of the Python script.
>
>  Example: tests/exitp.cocci
>
> +## cocci.include_match(state)
> +
> +If a python rule is running, it has matched. If the match should be
> +removed from consideration, this can be called with `state` set to
> +`False`.
> +
> +Example: tests/incpos.cocci
> +
>  ## cocci.has_env_binding(rule, name)
>
>  Returns `true` if the meta-variable `name` is bound in the rule
>  `rule`.
>
> -## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers,
> -       extend_virtual_ids)
> +## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers, extend_virtual_ids)
>
>  Internal function for the method iteration.register().
>
> @@ -28,9 +35,17 @@ Converts the string `id` to a C identifier.
>
>  Example: tests/python_mdecl.cocci
>
> +## cocci.make_expr(expr)
> +
> +Converts the thing `expr` to a C expression.
> +(Equivalent to Coccilib.make_expr in OCaml.)
> +
> +Example: tests/python_mdecl.cocci
> +
>  ## cocci.make_stmt(phrase)
>
>  Parses the string `phrase` as a C statement and returns the statement.
> +(Equivalent to Coccilib.make_stmt in OCaml.)
>
>  Example: tests/python_mdecl.cocci
>
> --
> 2.34.1
>
>
