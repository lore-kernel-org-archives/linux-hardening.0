Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039F2136C
	for <linux-hardening@vger.kernel.org>; Mon, 13 Nov 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="i/DSCsEK"
X-Greylist: delayed 84259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 07:40:56 PST
Received: from mail.alarsen.net (joe.alarsen.net [IPv6:2a01:4f8:191:10e8:1::fe])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5610FB;
	Mon, 13 Nov 2023 07:40:56 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:4abe:53a7:4edc:2be2])
	by joe.alarsen.net (Postfix) with ESMTPS id 1F5321810FA;
	Mon, 13 Nov 2023 16:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1699890054; bh=6h37m0Iem6DPm82r5P0FgDqnA5tsoGQsn/s7omraZyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/DSCsEKFWGHTyxmsvo0Txiro4iNSvQCHLf04nK8/FGsEQa+z/8QgHYjPx3cTuIwa
	 PSDrBUmLB5a3yXMbn/NEY2w6ugnEblXypJmN8DkpYTBeuP2AH5TJaFR0pJxk7VJSPK
	 qJnkg2jVqOAn62XEKrC4Tutxs9zkzzlT1DtUJ9E8=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id 07DBA14ED;
	Mon, 13 Nov 2023 16:40:54 +0100 (CET)
From: Anders Larsen <al@alarsen.net>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: keescook@chromium.org, gustavoars@kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Niek Nooijens <nieknooijens@gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Date: Mon, 13 Nov 2023 16:40:53 +0100
Message-ID: <13392533.uLZWGnKmhe@oscar>
In-Reply-To: <CALk6UxoRHWsJYuTcqg7zvf5rxGwMQymMpjGuSEw3d+syAVyt=g@mail.gmail.com>
References: <20231112095353.579855-1-debug.penguin32@gmail.com> <2655833.BddDVKsqQX@oscar> <CALk6UxoRHWsJYuTcqg7zvf5rxGwMQymMpjGuSEw3d+syAVyt=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On 2023-11-13 10:25 Ronald Monthero wrote:
> On Mon, Nov 13, 2023 at 2:16=E2=80=AFAM Anders Larsen <al@alarsen.net> wr=
ote:
> > On 2023-11-12 10:53 Ronald Monthero wrote:
> > > qnx4 dir name length can vary to be of maximum size
> > > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > > 'link info' entry is stored and the status byte is set.
> > > So to avoid buffer overflow check di_fname length
> > > fetched from (struct qnx4_inode_entry *)
> > > before use in strlen to avoid buffer overflow.
> >=20
> > [snip]
> >=20
> > > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > > ---
> > >=20
> > >  fs/qnx4/namei.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > > index 8d72221735d7..825b891a52b3 100644
> > > --- a/fs/qnx4/namei.c
> > > +++ b/fs/qnx4/namei.c
> > > @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
> > >=20
> > >       } else {
> > >      =20
> > >               namelen =3D QNX4_SHORT_NAME_MAX;
> > >      =20
> > >       }
> > >=20
> > > +
> > > +     /** qnx4 dir name length can vary, check the di_fname
> > > +      * fetched from (struct qnx4_inode_entry *) before use in
> > > +      * strlen to avoid panic due to buffer overflow"
> > > +      */
> > > +     if (strnlen(de->di_fname, namelen) >=3D sizeof(de->di_fname))
> > > +             return -ENAMETOOLONG;
> >=20
> > sizeof(de->di_fname) equals QNX4_SHORT_NAME_MAX, so this test fails as
> > soon as a filename is longer than that!
>=20
> I suppose de->di_fname can be QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX isn't =
it
> ? It's set based on di_status, if di_status is set, then it will be
> QNX4_NAME_MAX and otherwise QNX4_SHORT_NAME_MAX.
> We capture that into namelen, prior to the  string length check  - if
> (strnlen(de->di_fname, namelen) >=3D sizeof(de->di_fname))
> as below:
>=20
>         de =3D (struct qnx4_inode_entry *) (bh->b_data + *offset);
>         *offset +=3D QNX4_DIR_ENTRY_SIZE;
>         if ((de->di_status & QNX4_FILE_LINK) !=3D 0) {
>                 namelen =3D QNX4_NAME_MAX;
>         } else {
>                 namelen =3D QNX4_SHORT_NAME_MAX;
>         }
>=20
> BR,
> Ron

sizeof(de->di_fname) is evaluated as QNX4_SHORT_NAME_MAX already at compile=
=20
time, see the definition of di_fname in uapi/linux/qnx4_fs.h

I agree that the code is confusing, as 'de' is declared as a pointer to a=20
struct qnx4_inode_entry but in reality points to a struct qnx4_link_info if=
f=20
QNX4_FILE_LINK is set in de->di_status.
(Note that the corresponding field dl_status in qnx4_link_info is at the sa=
me=20
offset as di_status in qnx4_inode_entry - that's the disk layout.)

> > This quick fix (untested!) should do the trick (and avoids computing the
> > length of the name twice):
> >=20
> > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > index 8d72221735d7..7694f86fbb2e 100644
> > --- a/fs/qnx4/namei.c
> > +++ b/fs/qnx4/namei.c
> > @@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
> >         } else {
> >                 namelen =3D QNX4_SHORT_NAME_MAX;
> >         }
> > -       thislen =3D strlen( de->di_fname );
> > -       if ( thislen > namelen )
> > -               thislen =3D namelen;
> > +       thislen =3D strnlen(de->di_fname, namelen);
> >         if (len !=3D thislen) {
> >                 return 0;
> >         }

Niek reported that this fix improved the situation, but he later got a cras=
h,=20
albeit at a different place (but still within the qnx4fs).

Cheers
Anders


