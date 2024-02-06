Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB312D17A
	for <linux-hardening@vger.kernel.org>; Tue,  6 Feb 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213716; cv=none; b=a7BO9tap7T9sDsUV3eASNr9+1FkUVQaqr2qhgLX6d3q6N6nRB2c05WhHpG3Aer4rq9jHQo7sYpE7qKfCUiKWJLDrMZ6LVYouyeQ49/4HtBVNui/kMdcuLfaR6QE6z9c+UnoVXusi/34ScmT4ReT9D30/0QQJ60CSKKxqTs0epc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213716; c=relaxed/simple;
	bh=9vc9GRSK2R2a0IE6kgxEFThcWt1JUujvnbpMYfq17fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5VyCkxdZM+woSn/G7+ylq86Eruexj9AVvGTvw1ZApf19zyznJDXQSnVgXnYTTuJVtdE3ASu4yee1bAUeuOsBVSDyyU6GiBRbkWmP/nJwNS3zJr5jRiQ6eA4CtuLd7H89AZRDGqjnigGvBDrfpgEm+DYNxM2HDBwNTyr8fECIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h+vpCPLE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+vpCPLE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d8aadc624dso40500775ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Feb 2024 02:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707213714; x=1707818514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRhR9jRmXYeiA/qDO4/bNmHTbH+UMMuSM6BsgYcIZAw=;
        b=h+vpCPLEFoTPPUGp0XBHZnJLPQrk2L3yOFZukJQrwj5Ejhj42aqHzzUiwI7b+FoJGg
         dTX4Z1JFWzcte+rwtYdOuB99tV6B6q95GICHU4NHDeT8j/YmwcdEo3gyAcsZjzwL32yL
         NKPyBgQMyBfTvh36fFt/M5QNahPA7iAphs+HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213714; x=1707818514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRhR9jRmXYeiA/qDO4/bNmHTbH+UMMuSM6BsgYcIZAw=;
        b=o5FcjRzaUIQP9h4obfi1+FTLTyzOOJLu5c2pOaYBlr+KBSYFlvMsDqke6a/5gEpBrF
         rz/aXiufrGlJnBiv/JIsVQiQvU2ESLsYegFNaWsEE1kS51cQglA1vTtdTO4P/yGyxaeS
         F2RJSCQGoLq6IAvB8YRo7vdQkpsqjcgZqrQ1v+OFHHznmcydPAgP2xycALa8u9AbBAIQ
         g4GpsLWkgwnudm47MaAyh9tvJf1tzK4ITxzi+Lk9crIwlmI3pb4HLWopdknfyXrFhjD/
         3ZyhNJSg3Q1iqXOuB7x0RKX5p9NSJDjImhDrYv18LdWIgHGJLt7LV9I+bvPj30jzMxVP
         1t5A==
X-Gm-Message-State: AOJu0YxTGRkzBP46vLbMHkzQfEqkdMoxIm9NaBWEOACmzVZw+tvtNzZG
	EXLGHVMJ/GeTI1m+d0SsdfKFgWB5ZpbJzAf8eO1lpHGWcH9yZHl49aKQsRU5xA==
X-Google-Smtp-Source: AGHT+IHWL52WmPm6bNr953sUZX861hGdEh1n7cUglRSPLKTyvnf0g+GZMbpodtXl0TbQgxCD5k7UuQ==
X-Received: by 2002:a17:902:a3c3:b0:1d9:4d3f:cbf6 with SMTP id q3-20020a170902a3c300b001d94d3fcbf6mr1184238plb.48.1707213714084;
        Tue, 06 Feb 2024 02:01:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtZ/Q6R13798ruAgfiOliz2pPEk8pHcbZOrpqe+ZlQ1QcA0KXPlNsRmD9cBaPKSx+CPjSCFqYS2QVMPxKhObo25onG72wZnYuzopk3GBTWfgrS7hxKaR53VeYxR3RfiVNyTLL8s4gmOsjoIH1Eo4B+M+myBqn9tFiWIjTQMGRTcnxChejQh+oCVJwDKDDQ1yAsrNj0U/UbHsSA0dW4U/nvhs0CaE1oKtIZfEIoQtzwa5pf4hb4FLuEFn1xH26oNNrG
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001d9469967e8sm1455367plh.122.2024.02.06.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:01:53 -0800 (PST)
Date: Tue, 6 Feb 2024 02:01:53 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	linux-hardening@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <202402060200.EDE488F8@keescook>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <20240205202145.GB2220@sol.localdomain>
 <202402051443.A813E4D@keescook>
 <20240205231712.GC2220@sol.localdomain>
 <51025C22-0FEF-4047-BC36-EA7ED7A3BD62@kernel.org>
 <1ee4bd0f-2a70-4696-bad3-782b5c0887f7@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee4bd0f-2a70-4696-bad3-782b5c0887f7@prevas.dk>

On Tue, Feb 06, 2024 at 09:42:26AM +0100, Rasmus Villemoes wrote:
> On 06/02/2024 00.21, Kees Cook wrote:
> > 
> > 
> > On February 5, 2024 11:17:12 PM GMT, Eric Biggers <ebiggers@kernel.org> wrote:
> >> On Mon, Feb 05, 2024 at 02:44:14PM -0800, Kees Cook wrote:
> >>> On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
> >>>> On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
> >>>>> Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
> >>>>
> >>>> Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
> >>>> Those names are more grammatically correct, and Rust chose those names too.
> >>>
> >>> Sure, that works for me. What bout the inc_wrap() and dec_wrap() names?
> >>> I assume wrapping_inc() and wrapping_dec() ?
> >>>
> >>
> >> Yes, though I'm not sure those should exist at all.  Maybe a += b should just
> >> become a = wrapping_add(a, b), instead of wrapping_inc(a, b)?
> >> wrapping_inc(a, b) isn't as self-explanatory.  Likewise for wrapping_dec.
> > 
> > It was to avoid repeating type information, as it would go from:
> > 
> > var_a += var_b;
> > 
> > to:
> > 
> > var_a = wrapping_add(typeof(var_a), var_a, var_b);
> > 
> > Which repeats "var_a" 3 times. :|
> 
> Yeah, I think that's a reasonable rationale. I'm fine with the
> wrapping_* naming, and then the _inc and _dec helpers should follow.

Sounds good.

> However, I now wonder if those should really also return the new value.
> Yes, that corresponds to the value of the expression (a += b), but
> nobody would ever write c = (a += b) or otherwise make use of that
> value, and the naming doesn't immediately imply whether one should think
> of ++a or a++.

They were designed to return the new value, and the selftests validate
that. I've updated the kern-doc to reflect this.

-- 
Kees Cook
