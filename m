Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16B1607A4;
	Fri, 15 Aug 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273662; cv=none; b=KuxLZ2oh7tpMtSsP/U3Aa2XYN6+6ycqtXnuWRyMMPLEsz5naErONTkoS5cCiyFKgDZRcUQKd0EImOuRCLQDdf3T5z5BBZ4iwYmvRvSc2ZM/JuVgPG5SGsnAw8ggJhnWk/1wZuU2XIP7d8QcJrDseNpxISf+RcdCzpi0zeIhovNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273662; c=relaxed/simple;
	bh=eRUDrce47BqPOp008rZcmDRCQAYL6tsCtMgmCQUcvvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6B1hAiq0Y7XgHgoR+7BHqIvDVkxzqMVI/hf0JU1WmDDui72H48HeeYqZXgctBrQwYEvYpJnr2SKYMUvO/LlLwI4fR7I4DLGlcywXhFwvpZsFTSJXhn8jfl2tPHZxg+82UMxQJlSlmRbyeS5UYsaSjIcnhZ9m71msxPUm6DakR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn4b1wBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn4b1wBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42F8C4CEF6;
	Fri, 15 Aug 2025 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755273661;
	bh=eRUDrce47BqPOp008rZcmDRCQAYL6tsCtMgmCQUcvvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jn4b1wBCxht7szwJHKXRgZSepWqfAksQvhvy7AQNC4S39e1YrrCW7N0bnWtn4U/tS
	 E+0hmcICrjeoO9QLHxkRK+MABPxVLhAPZr6o7x3/VhOCqWx2aMdhZbZHkgNSdsPOW4
	 r1uUYmQcU0G75stxmb9D9IQvnATsoFHpGAHM+2F1cNH/B3aocL/U1fa3UG12lyMAct
	 0DG4FD2Qli3FZz2GqQ7Pd7iUwr+jYV1bUlwvdLSt4Iuhu4i5gHxNYF1r7920jNhbzZ
	 fGK/bfmtQ+Mg2YuyDprnqkQE4yz1j2pXeLP5+T8QhWlKkOoVO5ojoqzsQaN645yiM5
	 EgpeHMrJ8qBUQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f92b4072so15634361fa.3;
        Fri, 15 Aug 2025 09:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgS5fZ2A1CLKWPyoezYl1SDW17ZNhl59UOq4mhP2ZjBvWHUT6noWVw2NljyXF6DFwfTZ73FJdB7Ho+M7hV@vger.kernel.org, AJvYcCWVhiaYhwoDvdL3v+CfRMZfdM5inimFRDqiRN2+sE+s8XVvPgKeyGx5AjUYqmU6ay0/4HTNwFHjuixCfqp626Fc@vger.kernel.org, AJvYcCWw5JWjFlxFj44qmJMwsEmmvdNuLs/CVTSwAsvMiznNqB483DxW2rPV8P0cgTwtyzcXPcIlGMks0yQQ@vger.kernel.org, AJvYcCXy6VxntFs4Rc4tzqnZ9PN3QshY9oFt2aFQfSmLLVaBNkDdg1+1MeROrF78Yxz0JE5szfDc0rpp+Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCvE7PqwT9GrF900YXwa8dDgwEtcn2beOQgkhhLnxdhA9amd7
	zqO4U4LevNbVhg65y8dVaMx9dVewPICI3vBYXNyKF3dUUF7tc8+MT7Ru+zqTChnSFcRz+KYmaoH
	TmBPX/RTn5yRGsINi8iu2qN3G5kWe7NE=
X-Google-Smtp-Source: AGHT+IHEwrCso4h5YUSQfaAEPA8TR44kQ6AFZDpMvO0IXNauVtw+BfZ3azkucV1+vYX0CKjal7kHhwo3GJXj3q4Nscc=
X-Received: by 2002:a05:651c:19ac:b0:32b:3689:8d87 with SMTP id
 38308e7fff4ca-3340988a1c5mr7693321fa.17.1755273660445; Fri, 15 Aug 2025
 09:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815064430.work.772-kees@kernel.org>
In-Reply-To: <20250815064430.work.772-kees@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 15 Aug 2025 12:00:23 -0400
X-Gmail-Original-Message-ID: <CAJ-ks9=HYFEEENpZRADiA0y=EzLUc42ZCQLwGA0oVR6MGcP-Nw@mail.gmail.com>
X-Gm-Features: Ac12FXxobgu3WoXyaE05TcLbi8v8k13iVBNLRABs05eAFOJkKxXsLcsQqjxFvQo
Message-ID: <CAJ-ks9=HYFEEENpZRADiA0y=EzLUc42ZCQLwGA0oVR6MGcP-Nw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Add Coding Assistants section
To: Kees Cook <kees@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Triplett <josh@joshtriplett.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Gary Guo <gary@garyguo.net>, 
	Kris Van Hees <kris.van.hees@oracle.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Li Zhijian <lizhijian@fujitsu.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:44=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Both Claude and Gemini save locally personalized configurations in their
> respective .md files and dot-directories. Since these are continuously
> updated by the developer (and agent) when working on projects, these
> files must be ignored, much like how we ignore the debian/ directory, etc=
.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

> ---
>  .gitignore | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index bf5ee6e01cd4..0459a44a3d64 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -182,3 +182,11 @@ sphinx_*/
>
>  # Rust analyzer configuration
>  /rust-project.json
> +
> +#
> +# Coding assistants
> +#
> +/CLAUDE.md
> +/.claude/
> +/GEMINI.md
> +/.gemini/
> --
> 2.34.1
>
