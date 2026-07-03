Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB838306757
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105608; cv=pass; b=XEIN19elFdl+pxpOom9LUEFnK2OYxUJ1QHxepeaNr3nMA2vt/aJz9/VWEQmmBDN+bkr6vUmb6sAXBAWcXFbIFkKImA7ZNc/zd4bLMXmVy/u1jZ1OCocKZVTtjMsPEEfPwt+MSMIcFg1BKv0LmLBm0cKVGNzlbXcxZYCjjdHCCss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105608; c=relaxed/simple;
	bh=k3RPGAp9TTWRVSnJ9yi69FuEbvcNRj9QK7W0Z0AxRT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgvXBwjaWWAlyOB81A/OCATIPtXX3Yn7C342FPxEboHt7ZOCc65uDmIdRFCoDymauoJqr4/IfD2tTmeOpJ0Oz/rmzlj65O/eRyLxRBwCLmOdKOPreMVQJSeeGVE1L9q9o/OhiUzMRfrl/vFHs0FUZQ0qE8czn1Ps4zDGals8TnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1+29AoG; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1+29AoG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso1530665a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 12:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783105605; cv=none;
        d=google.com; s=arc-20260327;
        b=gQS1DS3HAXNfq4NDLGhzt9E9dm4dUrfjA7UmXV4Jlw9l9ztOveNcHIzJI+BawuSTE4
         AjGdxz18Vs6LNlImIalBVuSJJpx1oQxt0e0LeYMeU5NyU+Ad0/av0zYybAnxDSXqTMBX
         DAtpINo9SaIz0FGwr56eiydoAXCkvRT9Yrzvj1ckx2u+CM+ulu+76T+WRlsEdP14AQxI
         24++9s87OvY8Q8np9OTeQIJVpX9Fc5BJkzQHqnxU+/hysuWDcBOwVG5/Qdbd2Vb2RzQ+
         QzwP/RLnzU1yjMsWj1f0u1emQD3z1KQC6MahdDL6PWHB0qtzLsB3hFoNbKevc1m5DZ3a
         iYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptCq+Q5Te24m3SA3JXj8jjJzYrmXyLCdMsPnUku3kEQ=;
        fh=QPWrKCgBpbUsM5zXf+pHiWwJq79Hi69RSy+1ynOKwXw=;
        b=qd11pYhqq8YW0O8qZsG+wxdALkfl3yufWDoZkDD5YozoIU5fkE6dhXmWp8YsqwS8QQ
         zNj31g9Bw+1QC2a16wso/wKnBeiVLgXFB2JPiRVDcgvs2GtJFaSJr0IATTKYA6B68d6F
         Un9fPlJdpnaXs/tfVn2VD9Xeyge5EW2NPJPaxLfcKd7lZM8bf7l5L5byMsjr8XRt0nIU
         mh2yVwxgKxe4X7Rgmin+Q2OWfh6EyoLCMKaORUQoCP/JMKC1pIcAJVw7vz1VzvF0dsUU
         1YUiFKsTNKUfD8EZeWzij4hizpaJ/ZPZEfLP551nTezoLxr5oBpVdCey1ZiKmXcIeZns
         DyIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783105605; x=1783710405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptCq+Q5Te24m3SA3JXj8jjJzYrmXyLCdMsPnUku3kEQ=;
        b=C1+29AoGbNWZUZsXzo5zbHIWpQ83y5fHbsz+wfq6fkRCwbvtAUqLyKty40QNx9ioVB
         YeT2mxWQ/lMuoFP+AzL2EjDpcJnbwrJXjR6cMBXhx2mAjjfOysZYlZrXYNRd4lPODGsu
         YVmmmycmqcqWNGRI2JKW05Qfw7oQoDytRi9GMrUw8mXYwcNmXwT9Dbo/sJRg2xLO8Z3Q
         1FbrMqMJgQ8t2AmO2xnUuu2A77RGphpIrV3/a2Ij5e7dIG0GMuRAu7dzcHAas/4SGPTf
         Dq5ofa4oaq2XjL4fHgD1EwM2jFQ17TDhCwvut+Vj0TGKzdfZWbTPCw7ZsPGjQVEbfwMu
         QfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783105605; x=1783710405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptCq+Q5Te24m3SA3JXj8jjJzYrmXyLCdMsPnUku3kEQ=;
        b=k1no9zvPpe6gCpIk9VM5SaQQjz97W36+Bni/R3b8rGNaXbKTYKw5Bxs69g/COdkZgD
         ghkfqEBwzvd4Q7Uqw8dsUa5DkzwqNyjwSSG6PlYs2JxOJCjwECbARDpUpPR/5FyWhGfm
         F8JJqjBy96oQSLV2BzKYMqUBts8Ycn9rYLgTFCTkZwDkCYZjjMGqUMrpdidi+EN2cCn0
         PyA9YsW/NAc6BUSMM0bpRoOk5lixNeSs47iPVRIDArBlo6cdaXWVs+zBctVObFnzq9o6
         SqeFMjYJPEGEZ89cksJX6WW+/whNwneAYMER5jz1L/Xlx1rikGrrd76Gfg++S97wT5qN
         EpGg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9KdcWr02c4+ukQsSTWrjwEQ4Xoq768HTzykPaRpePGa2t9a9KA5JVG25cXLRBiRvDBG2KR+uCDTNdkL5fBD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyqEKB8tfVCGh+asq6rn/YMhI8te9v4lgzoNGcdE+vnFY8f6G
	B4isF+1FmfvOjp5r40h26xgWouI4ggo7VAUKsXM+L+2Tmjffl0B8QUNsZbzjg+KeegWupb4aDGb
	UboKGXV9dLvqWOTKY7Wr+gcyX6ZPBSjzpBA==
X-Gm-Gg: AfdE7ckK5iN9odbm6L0D+RS50HlgYS89XKoENw6wBxEkESEWihXe+i/w2VH1iR0DChK
	2xFCGd7abZZBSgaJiiFeB4pFUVn1Y05r8imSjOuBzLCGFXuX/ix25dk+Uz4rrDpSSxVLMkBpT8Q
	WAGL3zHeqn3UW2N1JjvZslIK8kaooaJWEXNC9vlAEfzeIxx18wgMwQrTmAAeb9T6tC0jdQ5nNUj
	RGBV9lBGP68h3gTIrDvbGkwM+Nz6ggXYtVwyY15jTR/NavUDnW/fM5eyRnKJkOoTCCxnhORiL7T
	SpBCIQBVnvw1WJXILcsoaI7GXHuw6GOoCV/EIex6TmQL0leA/g/l7VFSylwM02hjh/3e8M3TwZy
	10Dtjj/vBMExkhhZF7p2nydNgcFA=
X-Received: by 2002:a05:6402:274a:b0:699:2448:be63 with SMTP id
 4fb4d7f45d1cf-69a1a273625mr189718a12.16.1783105605235; Fri, 03 Jul 2026
 12:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630012101.1461335-1-rosenp@gmail.com> <17d381fb-1f91-461c-8315-1508ad0c1efe@kernel.org>
In-Reply-To: <17d381fb-1f91-461c-8315-1508ad0c1efe@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 3 Jul 2026 12:06:34 -0700
X-Gm-Features: AVVi8CdaQFcBWDWlMOsDL-RbGTiwVSxCIdUvl5QYiWhT7_pjzoXOmEeBUlTudQ8
Message-ID: <CAKxU2N8Be1XxVznSrV1KGWOyivNEFJjojd2KRXLguLYZEB=gYw@mail.gmail.com>
Subject: Re: [PATCH] scsi: st: use kzalloc_array
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-scsi@vger.kernel.org, =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:28=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 6/30/26 10:21, Rosen Penev wrote:
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> No commit message ? Please explain your reasonning, because I find this p=
atch
> incorrect. See below.
>
> > ---
> >  drivers/scsi/st.c | 12 +++---------
> >  drivers/scsi/st.h |  3 ++-
> >  2 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> > index f1c3c4946637..31ae189b18e7 100644
> > --- a/drivers/scsi/st.c
> > +++ b/drivers/scsi/st.c
> > @@ -149,7 +149,7 @@ static struct st_dev_parm {
> >     mode counts */
> >  static const char *st_formats[] =3D {
> >       "",  "r", "k", "s", "l", "t", "o", "u",
> > -     "m", "v", "p", "x", "a", "y", "q", "z"};
> > +     "m", "v", "p", "x", "a", "y", "q", "z"};
> >
> >  /* The default definitions have been moved to st_options.h */
> >
> > @@ -3973,21 +3973,15 @@ static struct st_buffer *new_tape_buffer(int ma=
x_sg)
> >  {
> >       struct st_buffer *tb;
> >
> > -     tb =3D kzalloc_obj(struct st_buffer);
> > +     tb =3D kzalloc_flex(*tb, reserved_pages, max_sg);
> >       if (!tb) {
> >               printk(KERN_NOTICE "st: Can't allocate new tape buffer.\n=
");
> >               return NULL;
> >       }
> > -     tb->frp_segs =3D 0;
> >       tb->use_sg =3D max_sg;
> > +     tb->frp_segs =3D 0;
> >       tb->buffer_size =3D 0;
> >
> > -     tb->reserved_pages =3D kzalloc_objs(struct page *, max_sg);
>
> reserve_pages is in the middle of struct st_buffer so you cannot use a fl=
ex array.
This patch moves it, no?
>
> > -     if (!tb->reserved_pages) {
> > -             kfree(tb);
> > -             return NULL;
> > -     }
> > -
> >       return tb;
> >  }
> >
> > diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
> > index 0d7c4b8c2c8a..759f4c43d563 100644
> > --- a/drivers/scsi/st.h
> > +++ b/drivers/scsi/st.h
> > @@ -45,7 +45,6 @@ struct st_buffer {
> >       int syscall_result;
> >       struct st_request *last_SRpnt;
> >       struct st_cmdstatus cmdstat;
> > -     struct page **reserved_pages;
> >       int reserved_page_order;
> >       struct page **mapped_pages;
> >       struct rq_map_data map_data;
> > @@ -53,6 +52,8 @@ struct st_buffer {
> >       unsigned short use_sg;  /* zero or max number of s/g segments for=
 this adapter */
> >       unsigned short sg_segs;         /* number of segments in s/g list=
 */
> >       unsigned short frp_segs;        /* number of buffer segments */
> > +
> > +     struct page *reserved_pages[] __counted_by(use_sg);
> >  };
> >
> >  /* The tape mode definition */
>
>
> --
> Damien Le Moal
> Western Digital Research
