Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDC1B6CF1;
	Tue, 10 Dec 2024 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803969; cv=none; b=jVsixKyGUpBGfykjk4F1QOiDhKTAlT4EXJdRQw/wrPHqKjcjIwoNr0I3DtAWGRxggGyGt0DRa4jlcsd8l27YZLqTAG2U1n2/syr8lvBYiaJpgrADbXLyKrV5dojEXV7Os+wmCJtsdPNT6elk+UZxRzOo4ex59GdZUpZ9xtdIh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803969; c=relaxed/simple;
	bh=zAKxtJz5lIuHNZsD4TM9Qq+SOFQB/YTUskvPFapr8f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RX6LUXi95NHCmoFvuXkv8w7ZiG00+aiamEFS8IkGLYj2XvrCaUvLGqmZAteTAjF2d7ozUM4HlURrOLY62DhwVr74HFWmdGyIGo3uiTnVctwra0Ne0zaHMgxgvz4pjX9GaKlMIYdNVMi1//LkeZxmsXPFHDDBnWZyfpJ4W8StkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMeOjp8F; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMeOjp8F"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso55357601fa.2;
        Mon, 09 Dec 2024 20:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803966; x=1734408766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhSJXbd5dcODOekyvOZZ9jDY6cmQtFID8ItdO0O4slo=;
        b=aMeOjp8FQBeElWjlzkWj+HHsiI14Fg7AbGvaM2efxUhJf6ID8b+J5Iw6Z8giJdS5kp
         3U+j37QtbEL77WvcjMTWhsFQ4Is7QcWmDWqq0WEqW/3yMkT8me582BP0lDkQmanoEXyz
         MJr+Kg4CqmjXHF36l7V1keq+mHh8uhl810U5jLOqa0HpEYNw6CuSpwHBDJcRoewRTmkk
         bXFxKy8PFZWiA/TLEU//X1UftJxjIbA22wSDghVrdPahaRnG9LC8frgzlngXgcto42VX
         H5zMpYMAwDpO/06vYIR8illY647GRHDqoQT8X07e2LZ2spFnvNGXf2fNWbcaGkge4BsI
         VfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803966; x=1734408766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhSJXbd5dcODOekyvOZZ9jDY6cmQtFID8ItdO0O4slo=;
        b=nlLK0nj6DYzmvUWeK+Ah7X46ynvPqKL16mG6xkgzxAiq5ZvH/ssAOePYvottJD9Aon
         mbhfvULX0pLFWKir6SU8AH9gjJuqymJUC2+jezleTZE6kagEjazOIbJKZ6rhMQdtLVzs
         P+7TY6uUxXG9mfHYFCTEkLQGZ0zxIRYfo3UygdqeuHCxXThdBleyYPE2f5xEekOf3+PZ
         mnG0GIGcCzWLyYTStgt56aBMSwdn2NwU18hPzJqRFkVkJHBk8E/CnMnhB/dv9swmT2+I
         dlABCXysr6lzCoo2YmVMTX0vbOc2Witz3f953+p52rskrV2I0cboktZ7dl/DsUBc/UD2
         qpfA==
X-Forwarded-Encrypted: i=1; AJvYcCULaxJZ0ea6KkUF+Pj7suDcaO7ghtY2wH6xpATmdxYjpHgdhW3/cGLh5jZ9/ocFHv4J1ZD6YsayCR/Mlzqdo7c=@vger.kernel.org, AJvYcCUQcS8SK0ci9nlLExttj9FEkOfxvihnjYfHIEjNRZCHGv7zZNHpjUSI6KrdrvOljeCS5eSKoSN1Yr2NNCkH@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpbNhRWNIKZmX9tOTGzdb7M9xu619Gt1aJTcAmj6lj0fSIyzt
	7HMy9+gcozi9bMkH6luweyvcxtSSJ48csHx3pWdy71Fb2jDjNGW7cqh4q34YizXudEfsoC8kFoC
	vCN7/ch+ffrDDe2uXmZ6rm3c/5uM=
X-Gm-Gg: ASbGncsMTSUobMdsbhxx400M5IrROdgQSmO4jrZGHfoDmn+LHF2lFpQM/C7QQ4Vue5J
	N5FdrN31B5RKbYp956ThGviQ6F0SlnDrDmAQf
X-Google-Smtp-Source: AGHT+IGqfmjIKRHlYBEVRB6AunCa6PAIG5SYZ5EV0do7KYm3Jg6zd5a6jxntsUDLYr0N6g38rUiV7l3l29PwO81OqR8=
X-Received: by 2002:a05:651c:996:b0:2ff:d49f:dd4b with SMTP id
 38308e7fff4ca-3022fb4e932mr7132821fa.15.1733803966011; Mon, 09 Dec 2024
 20:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
In-Reply-To: <20241125202021.3684919-2-jeffxu@google.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Mon, 9 Dec 2024 20:12:33 -0800
Message-ID: <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:49=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing or unmapped during the life time of the process.
> For complete descriptions of memory sealing, please see mseal.rst [1].
>
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization, and are
> sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [2]. It is sealed from creation.
>
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems.
>
...
>
> +config SEAL_SYSTEM_MAPPINGS
> +       bool "seal system mappings"
> +       default n
> +       depends on 64BIT
> +       depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> +       depends on !CHECKPOINT_RESTORE

Hi Jeff,

I like the idea of this patchset, but I don=E2=80=99t like the idea of
forcing users to choose between this security feature and
checkpoint/restore functionality. We need to explore ways to make this
feature work with checkpoint/restore. Relying on CAP_CHECKPOINT_RESTORE
is the obvious approach.

CRIU just needs to move these mappings, and it doesn't need to change
their properties or modify their contents. With that in mind, here are
two options:
* Allow moving sealed mappings for processes with CAP_CHECKPOINT_RESTORE.
* Allow temporarily "unsealing" mappings for processes with
  CAP_CHECKPOINT_RESTORE. CRIU could unseal mappings, move them, and
  then seal them back.

Another approach might be to make this feature configurable on a
per-process basis (e.g., via prctl). Once enabled for a process, it
would be inherited by all its children. It can't be disabled unless a
process has CAP_CHECKPOINT_RESTORE.

I've added Mike, Dima, and Alex to the thread. They might have
other ideas.

Thanks,
Andrei
