Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2D7DA73
	for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742581; cv=none; b=pV7JlSwhO+I/yxDlnhG0zeDS0XUp/KnhXQQLdNWSB+7s/jUQq28OzrawhHHCjNlsNj3APBJ4a6dmL0c0zdOZk7UCF4pv0VYSdLL18wvweNTr5r5UniFdi+NMVHgjneRGwbO2ldyRU2kVRjbeIMZaT6Uqy6VFw/JUtV7W1xHCjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742581; c=relaxed/simple;
	bh=d+92bmdJWL8dG05kjul1M2zn2ivm48HvaLaUolBE4n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fgWfPRk0av3Pp8fZqxtToQ3AZYeLypQuI41Ao5wD0dYRLQWd6+xUG22b4UltIzJTlrke+OVUSw2I/tbPnpgf6xgyrg4Y7ZwAfslJCKJE/00Oui0DNbmisEAo0nuO8XSfvJohJuePM4t6LXEG5uS09/ghu7xOVRJcCTnL3TprDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLieWqsR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLieWqsR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso275a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723742578; x=1724347378; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc9txLFNP269GzTRVSd78UBtF6r7wyFfjH4FKGxwoMI=;
        b=bLieWqsROwQv2NXegrKpzv6O0RtVW3IwLZMnGJZfs/YnpLwcW2oFzodfCgjdvDCZmX
         Z0VQAT9v+WUujYBi1TF5ACwnUdLJycV76kEFLbAqJTw46EpPcSLx+aKzbk83PmqR+X/x
         PwZdv3d+ZeI60faPtxcUh13FiO6X223AdOma6olAhnwv1vZYTmzYVPaJKeb4QImtZvuI
         3N4s6hUHoAZkjecnBRQ0sGuwACVt9+b1wG6QryOLYH+EH8IAqxafBDWj80PzbeFTSjBi
         hMxUTL/QtBTD7feF4ARThHzt0rVjYJ2cnGbSZvH9Qzqm7dlBBG4SsIz3fYl5KrgXonm5
         ohyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742578; x=1724347378;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc9txLFNP269GzTRVSd78UBtF6r7wyFfjH4FKGxwoMI=;
        b=HoG82rBp3GeASxDrUF3peIOThUO33xH8oAGdoTt5eg3vtIXtHD+7nwH3Cd8+49wbUG
         wkFGK4mwXsn0EEfZTLCZeLxQnQfk5YZYWtuwLJmqOrcn0QB2NHfbodKnLViSoromHOoQ
         w0XIOGcSfNOJTA0QZxL29JKNPxdbP3v67aLhxAQqFOUabRXMw4uPXuWa7cbUVTWNxgaI
         zyE+CTNwQqgCawCdnBTDvaO9kV7YguImRSysQnEJPuDNQaNpfsP1C5L/E0/8drpYmO/I
         K3Wgwe0gZ8+sUdAKRB1pokVRaA90Lt66L0PIRXSA+/fQYDuI6YKGakAXw9aAqcKdbHrX
         GaWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfPwC1XuFBNhh+WH1F5IoVh1SAaSsQEQSvqPUcRi9fQqOH5/bU+NvcdPniXySBbJzZaNrUHznX/ZR6kdw5W1DfJNxeD5ywMs2ZfuIXB43
X-Gm-Message-State: AOJu0Yz5ylTAUGvrSTBqpoNrcCi6Ux21E8q/2dphNpO/Wc290ha5Wt6v
	UWN5CRbp+MldFcSsf7JK97RtRb869KxzvqMO6zLT06jv4QqZJoP3HVmafHRfuBa8A836hXuY4yt
	gWmFNbegLa6Nx43zrtODSCW7hFK/FjZQk1ybQ
X-Google-Smtp-Source: AGHT+IH7huTtE6fqc1WLO9yn5yOimi0bsXeAv6AujezGKXJ6Yhws088ojXAnpq6aCfUkHr5tUp+6H1NTcUzYk7TsaZU=
X-Received: by 2002:a05:6402:5201:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bebb9c498cmr82226a12.3.1723742578077; Thu, 15 Aug 2024
 10:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com> <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
In-Reply-To: <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 15 Aug 2024 10:22:18 -0700
Message-ID: <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, willy@infradead.org, torvalds@linux-foundation.org, 
	pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > > The majority of the comments to V2 are mine, you only told us that
> > > splitting a sealed vma is wrong (after I asked you directly to answer=
)
> > > and then you made a comment about testing of the patch set. Besides t=
he
> > > direct responses to me, your comment was "wait for me to test".
> > >
> > Please share this link for  " Besides the direct responses to me, your
> > comment was "wait for me to test".
> > Or  pop up that email by responding to it, to remind me.  Thanks.
>
> [1].

That is responding to Andrew, to indicate V2 patch has dependency on
arch_munmap in PPC. And I will review/test the code, I will respond to
Andrew directly.

PS Your statement above is entirely false, and out of context.

" You only told us that splitting a sealed vma is wrong (after I asked
you directly to answer) and then you made a comment about testing of
the patch set. Besides the direct responses to me, your comment was
"wait for me to test".

If you will excuse me, I would rather spend time on code/test and
other duties than responding to your false accusation.

Best regards,
-Jeff

>
> Liam
>
> ...
>
> [1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaA=
To+-8MuRJ-g@mail.gmail.com/
> [2]. https://lore.kernel.org/lkml/3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbay=
w5ntgk5a2rx@jkccjg5mbqqh/
