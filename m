Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79364340287
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091651; cv=none; b=PkXgMxju6Kf+oEj+tkwTNzqUtRlFfZKBCZLskXpl58frOyt6yDwjSWXzoBv8n7Tq8ssEMPEToOSOpE44t13lC7pjBNZpyj9RerxITEufHlYWeiWb43gkAXE4WiyLo7csMZIqULJY1JnP5Tz4Lxf8v7G6qe4OPqRwH7CLsI/yg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091651; c=relaxed/simple;
	bh=FYDwxVevGf3SfJYzsMgqLMkL4LHEXb8iA3/CNgA1Uak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DV2Nurznuv3tjYps1ZpjVoQO+E403CQ7gQ3yMwlkPqkabCGSPG9grLSA7qSEAj104incYxWC/aqVUbAS+88DT81WE3ldThHTJ+H6dbwN0dP9nU8SPPB8T+Hxae+jgVi3h2lNSHcoO38cvsm/VwlHWRizenXktnKbtP+za5Hg/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB0eSgKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB0eSgKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13669C116C6
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769091651;
	bh=FYDwxVevGf3SfJYzsMgqLMkL4LHEXb8iA3/CNgA1Uak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sB0eSgKThLdOAqj3gcxr3+98P70Y9FX98Civ6l48zI5Snc5jIx3WUhnpbcaxHfyTu
	 ORBo7tiH6mXXDycplosv8XZ8RqY91yrpi8jWdbvI3zFMivQeXN8VHydP0bn4f7xFW7
	 uiI/vpIuxNl/0PT98RgcZhohD5vSnX+P/FEpeJk4nVFUC+FhAb8y9mk7GoYvI4Uwp+
	 C07f1cEJtmqt8O9CM4S/CmBOHIVwbG/cPfF6E8kJ7uWiJRAKsRg9H2o91/g1hDD3vk
	 iYiFL8M96aCQ1/fUrr5R59QqkO7LP4OjA8Rdx0tN6WMGnE8v+EoyIYTNrNgTRi+sra
	 lRueFZz0h9nFQ==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34b75fba315so674517a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 06:20:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViRsCmt00CFPCzdNNF9iui6sDNkF67n+PnYkau/4VKy341Ynq7DnwXQdZ2y7APW+RTYG2sEahcmUYrqZ3jOr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOlVUqfV8xxWavhdf49e/sT2bwoJtrKUwgjFJVd7pJVaUtHyG
	xDPy+F8LPzZdm6H0B/d3WAXJ7hMhq1Dxbg8/Yu5IYzmgcLbXjZg2WrXwd4RPSRlUk/n5/L7XkjL
	66UUTNztDlzBz8j5wUgiMMpR8rr9SV3I=
X-Received: by 2002:a17:90b:250f:b0:353:34a0:3d82 with SMTP id
 98e67ed59e1d1-35334a0419amr2193706a91.12.1769091650661; Thu, 22 Jan 2026
 06:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local> <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
 <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local> <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>
 <20260122141606.GDaXIxJuTqPFyqmVJG@fat_crate.local>
In-Reply-To: <20260122141606.GDaXIxJuTqPFyqmVJG@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Jan 2026 15:20:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH6XCTCeEFDkn+8zygWR=Oq-h57VV3YyX+n+CjH98eNKg@mail.gmail.com>
X-Gm-Features: AZwV_QhqcY6uWyGEoe_Fc1r4Q0gp42Jf0YzEfQhwTJxFgTBFAvl3dQNocMmb5yE
Message-ID: <CAMj1kXH6XCTCeEFDkn+8zygWR=Oq-h57VV3YyX+n+CjH98eNKg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init section
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 15:16, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 22, 2026 at 03:09:19PM +0100, Ard Biesheuvel wrote:
> > It does. It just doesn't prevent if from happening for other reasons.
>
> So this reads to me like "it does but it doesn't". Huh?!?
>
> C'mon Ard, let's be more precise pls.
>

Fair enough. What I meant to say is that if your BSS placed on a 2M
boundary or is sufficiently larger than that, some of it will be
mapped using PMDs, and this change will prevent those from being
broken up into page mappings. If your BSS is too small to be covered
by huge page mappings in the first place, this change obviously does
nothing (except fixing a bug on i386)
