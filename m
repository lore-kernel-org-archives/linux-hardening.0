Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4813C66B
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661825; cv=none; b=dIi+t7zmV88+CMkrofS0z19hIX6RXnv8RcOGwjOCAb7vLJulkbkWV3N35rzFfPqHDkXPrEbDSbAGpvuYPZDrYnd0MsWxfx0v7mHHnbm/KJN2FQEoLTwJP2BQOzfdJdPLB6Y3AptIfLAmlA+F0TDKAarqRwWugDoh1MpEWi+WDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661825; c=relaxed/simple;
	bh=NH4QIZCd1e7ll0ytLJZvsXtnpe6W+YknkMOUe2chw/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5MrC2oXWwELZ2woIZRMC01IIXRcSK2jPfoA7ZctAA+lWBOUd7U/Tnm5ApS1Q/2bHsLtU4sgSq5cIGRwswkTT15TQJ6y7qJPV6zgACP1lwoX9q8ACtAenTOrHgKMot3MgL/36/Rd2ELQtw07dLfBztf0lVj2tmeBtTgqTws+jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kOUi18yF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOUi18yF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecec796323so7703832b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661823; x=1715266623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ8b7bzfCx6EpLlIeYt5D5YIUVdmKAgE9Z3grYfPDDo=;
        b=kOUi18yFJznxD0I7D2bkIZ7g/Dz5s7ufRd99GwsVKDDJ/1k+Iz8WyCULX0lfMSNvoT
         N/HMqCqJr8xQsdqdS8JzRgFSHfLSqGXlrDFq2HYc1VTvBTvH7JQ2KGDiYJ69ZGa1xpv7
         V8Ut/VQq+OdKe0cQfjViVvID918nnmV699qGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661823; x=1715266623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ8b7bzfCx6EpLlIeYt5D5YIUVdmKAgE9Z3grYfPDDo=;
        b=b7B096Pdb79uUB9VmlZM0vDLfvvJwICTm0nbt3YGSMK18NYnHqR+nwf5aCcEWsW6jF
         reDBRbDxV2gDX4Ctl0wR9tcjZqIosBmQoQGRcC1JVYjS9icciMdkmSYqER7OrCoe5X4t
         pJObLEAeX2zh/Qaw1go5OYtbZ0nI3JThNWv9rqGJh6qWVI1OJGWbeJXpVudldouYBPgB
         2xZxMIdE3Da4/NQZzE8emmZdetlDXskxxYP9bI6bWxB4mrZA+NzTmzvQtVBkWwvtEicv
         846UgFBEQbBw9a3kgiOoUP5R2szUbUI4QhYRBKyfu6zNltbpj/GZbBrksBMqKqzK8Jzd
         Gi/A==
X-Forwarded-Encrypted: i=1; AJvYcCX/HQYcgBdHyyXCLH76FBNZAnHybk2LH3wDTc0LuCVd4jHYDTg9dd2PCR69BV32BmKvcPtSaBdZtBav+ZBqwtVs+tJ8QWgpjbCOGYI+b/xQ
X-Gm-Message-State: AOJu0YxQOdVBHyYCSSapeU8ChYCYWGlv0OrKx/CMc8RvMuzzcogmXeXT
	gnsJPQhR+m3r5z3FjLA/tunBHNVNGrtIl1WoKm1hFq237IL6umo/oSjljPBfOw==
X-Google-Smtp-Source: AGHT+IEY8rfhYcGUjn6fkFZDVe5VtFVRmGTt2Y2qKWiykKokE+sE6ybt9GlDY7wg6G8EAaWAzHcprw==
X-Received: by 2002:a05:6a20:5b22:b0:1aa:411d:a8e with SMTP id kl34-20020a056a205b2200b001aa411d0a8emr5633798pzb.62.1714661823495;
        Thu, 02 May 2024 07:57:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cb5-20020a056a02070500b0061236221eeesm1175970pgb.21.2024.05.02.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:57:03 -0700 (PDT)
Date: Thu, 2 May 2024 07:57:02 -0700
From: Kees Cook <keescook@chromium.org>
To: David Howells <dhowells@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202405020755.0101DBCB@keescook>
References: <20240424191740.3088894-1-keescook@chromium.org>
 <20240424191225.work.780-kees@kernel.org>
 <2100617.1714117250@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2100617.1714117250@warthog.procyon.org.uk>

On Fri, Apr 26, 2024 at 08:40:50AM +0100, David Howells wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> 
> Ewww.  Can't you just mark the variable as wrapping in some way, either by:
> 
> 	unsigned int __cyclic counter;

Yeah, that's the plan now. Justin is currently working on the "wraps"
attribute for Clang:
https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook
