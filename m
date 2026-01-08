Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6768343D78
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879218; cv=none; b=bdHa43nwJwMt3HhiXGbOD4OmE6OLcb1k1Yq0oaCGfaTBpdG80iElinSCWH4gGpKHGonMWOTmpLRRNsa2nYt4CLpbyM2tFeb/GIJZ5L1NXcJGx4gqJSGmRwaNo5Joo/+UxC0gSl/k6Xz5im6XYwxSqsPGSzY63BWFuTj2t+ihZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879218; c=relaxed/simple;
	bh=ndFWMjzooieb5xyGu4cJGAmspejtFb892UHQx8ZDIZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6/nlwCnKXYEl3dPU0XQOozEvE9rsilBYaILD7EFPQjnOYsj/Y8Q88RvCT+pZFw/2kYQHN67vA4xEgtGyr2/e8JEg8OqjpQtrNpBO5+WZl8BqDL04xp6AFxRnmKcHSSPm3yUdysIOhcYtNuL9bcfSByz5Rc4tbaC0bF5y9Anq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/EdmpCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/EdmpCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85308C19425
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879217;
	bh=ndFWMjzooieb5xyGu4cJGAmspejtFb892UHQx8ZDIZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/EdmpCVAgDo4biXkfjQarc2stbaiMWQEmRJ1angulctDwmO0To9YiVUXM47LcQAz
	 9JumEOXs+aGTeBjDskczURd/bqn3+g8H8y7vfo3tMeTr29Nx1pLHPn7QruMeppGtW2
	 DiQTYhRsJAjxAjVZHz5qn+ScVq6zT8sjyj3u4MaK9IanNX94b0iWq7c6IGjmYSqr9g
	 Q7dLbBjzeQo0oxuHwhpjzYikcdjeEmq6dhNPvJDYpcgQY32A4kTqVez6TOT/+P1oe7
	 egLt3HUrsxgq1X0SFmgaYPyOxXYSB6nyKKEGnKDLg6yNn1eIYBdDHU5IPtXEHyZI51
	 QAiIbX0qWNS2A==
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c525de78ebaso535235a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 05:33:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBvm6ySSVNkJ2h/PgRMn4FbK7GG2KQRWy9JIm5pQKsbvqKiet1BmpPMovd544YaWY75qd453lvDjCE4FjPcXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxCq2VFfpZEeKbrXYD1eeR8I0dAWMbTgA+t3G2ZHHDkQqF1pJ
	LP8gLLI+6FVSCcStcLIVec/bKLb9VYSLrtRS0Rsdc/9E9i+vgf4t6+z7DCWgtik3yCWhxGg5adC
	tbsiikEipuRqjDYq7rPl+rYf8nziymLo=
X-Google-Smtp-Source: AGHT+IGHIvVUprNBdrwsC9Pu7WwhWkbld3sZP0htQ2g4aAHDfX7s6G/JSDmknZne1WKYYALnNgfSsY07pebvo+Z3TWg=
X-Received: by 2002:a05:6a20:4308:b0:366:14b2:30e with SMTP id
 adf61e73a8af0-3898f9cd7ddmr6454679637.65.1767879217085; Thu, 08 Jan 2026
 05:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211040935.1288349-2-ardb@kernel.org> <CALxfFW4gyv3gSc1JhkPNqk4LL6S6gZbDRJx2y21PFZ8-8_9s_A@mail.gmail.com>
In-Reply-To: <CALxfFW4gyv3gSc1JhkPNqk4LL6S6gZbDRJx2y21PFZ8-8_9s_A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jan 2026 14:33:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG+6CYVSV-2ZSqrEm+B=az+54=fNwHpC_6qQZ-z2=3Zgw@mail.gmail.com>
X-Gm-Features: AQt7F2oKLqFPgsT5ujde-bH1gL-fZZo30xTo_SHI9xAc2C3fpX2TG9hkL1r-C9c
Message-ID: <CAMj1kXG+6CYVSV-2ZSqrEm+B=az+54=fNwHpC_6qQZ-z2=3Zgw@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Bring back linear map randomization using
 PArange override
To: Seth Jenkins <sethjenkins@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, Liz Prucka <lizprucka@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 19:14, Seth Jenkins <sethjenkins@google.com> wrote:
>
> > This is posted as an RFC because there are obvious shortcomings to this
> > approach. However, before I spend more time on this, I'd like to gauge
> > if there is any consensus that bringing this back is a good idea.
> I may be a minority, but I do think bringing this back is a good idea.
> It has now been 9+ years since hardware side channels for bypassing
> KASLR were discovered, and it still appears that real-world attackers
> overwhelmingly prefer alternative strategies - such as this one.
>
> I'm under no illusion that if we just do this one thing KASLR will be
> secure again, but I think this patch would still have a meaningful
> real-world impact in terms of making exploits significantly harder to
> write.
>

Thanks for the feedback.

I was hoping to get some other views on this matter, but sending the
patch during plumbers and right before the holidays probably didn't
help in that regard, I'm afraid.

Any thoughts on the desirability of this feature wrt randomization of
the placement of vmlinux in physical memory? AIUI, the main issue
being addressed here is predictable placement of statically allocated
kernel objects in the virtual address space, which could be solved in
either way. Or are there other concerns here?

Just trying to elicit as much input as possible on the list, so the
maintainers can make an informed decision.

Thanks,
Ard.
