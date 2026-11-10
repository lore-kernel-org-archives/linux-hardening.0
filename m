Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794307951;
	b=DiZ3Xsv07kTnui9O20uyfWzxEKhMJcPDq27LatBxhfeo8THrI0GxBsoGlVtuZXFIYqXM
	 Gwp65e6MmToFeBILtPFDZ21YMQZvwTXtcWdKNeozjv/LzsUmnW97TlrfSFbn/fcqp5XTv
	 E2r5P7wTM8NPVv83bT466xcAdPj3LlVnfUBxa5Z8pfPsyOHYdV7GHEdmjVmMAI+1AOYlo
	 Up8bRNSKjgLsgR8TUE7ZdHlWhqsDhgIIGr4V+p5iOqc22hveb+8anHpBPQ4TOUVOO5AS5
	 oSKlL8s3wVvcT8rNf3DonqjM2XLBTQY9OKoGsn3ab8uYWWmE4LFu7L9SF5vw4M3biyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
	b=2XoI2BAdXRWJqR7A37HS17Y0oUCEbrDHQH/TJW0iAClAl+X4vDX3zG6unTDptyvOj14X
	 ZKHW2n3TgjG7zNBSUR4XR3e0xx+BupazcdX+zMvYfijS5DkIl9RFj8q3KwRN7nH2Eo4ya
	 I8o1sxAy5KA6W1k94UqJ0CikCrKhj1wY+JQ/8qLqLfn+bFoxhpy0D/Ec8iNpVWr5N8cgq
	 4Sbn9kq+LMIvG/NtaJrnhxJVtu2ubCCLKwCe5zVqdOYHZFyQPnfM/orcjgrFkQxPI+V6V
	 GGHdbyRQSx+4pQcaY1HHogaQ9r0NfTimRmALpj8+SoyI7za/zwj4itBPpQ9SKYBvPzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2yKUg4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FF606A332
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 10:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 356FF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2yKUg4k
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b354d27917so15364517b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 02:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794307950; cv=none;
        d=google.com; s=arc-20260327;
        b=ns95gMekmsRSt2DrFDJvsgDkYV4MySGmpApifm6g1NoB9vG+FF7bjv7g7f5JhRW0Ky
         3fr3tvtvKBmZfibn7W/tXpkNE6fYRUPda1vgzv4kx+cbppgxsULj1/SLpQD7jv67RntS
         TnD3u/xSdMJz1rMJynMSZVy+J3OsLMrXXqXXRzeW2XuP7zuzvyRasVK71bfs+tSN2Pz8
         gYADfZicJZ343FvomMk6rVAUKUbsgNlg/qEP9CYJnIx2ppopeGfSi/zBNBT4Ig2bfo49
         LuDhZbKC+sxwKXtWXgDdG0gIviXizslmZwAaDPSnCSsKUIlj8ZeBFSincyUQKaFX0VNJ
         CTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        fh=szLC75t/ZkMTijNlufEYolcwSs8umhmvLoNO/gGKSQE=;
        b=YWPUzsRfyrw8QGd31aN5LHpMmg4p6R1ddJK8jBtCxyCmEg9sRz4aTOuGHSLOYrlO3j
         mZCNbLxvoVdztFd2O7k1RoJIaotiHg0WOfLRF2R6XGxeHg2AeEuRzPm0dnvPdrMWBGQh
         HNTBYf64gowBQTxhUlnsjBFLayr3kX+KEXcEEeq2h43TQzIALFgbY2GAmgPLVb7pTDW9
         V1s1BtzL2vjwOn8dTtwyUMYkmE68EGs/Paeh6ayO+EosYiOhTYAbvm/lJozQs3CGXqtJ
         hFXicmkiiLIpWfJSHlCVcd/5a9FCmiae80ZryqCb/AAjXkvYDM8RNjM5OguKe5/dXmyb
         OoyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307950; x=1794912750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        b=G2yKUg4kkkNyrAQLdA+svzeZn6bsiQXP/vEdrNCmE3xn8ePwe7ypVchrXLzPlmsfmW
         lzJ/znIv2TTl48zXBASM/vBEzAZQnZV3IFI5K7mcP1Sn/aQJmC0Q+3u8jnETQdK+OdKT
         UMrinFt0wmlR5B7U/Wi6+upm+BxqtF+PZgq6G7oUC/R/Rve1Wc3Qgg9fKoBY1jL0KR5y
         wgYtSJTLX2BHOwgJdKHSOoj+wx6LNeG9PNM34mQWbkp45RbZKXP4v4JWPrUO0bsZObJ2
         PjKKSQAC6V527ZMIejd5C4uGw2iRY5wETwfo5byFtMVf+095etPOYZnI4Z26jWNMjqMB
         xylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307950; x=1794912750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz1/GqxJfr5fovZK3WCpsTphS4Ees9ZlA9FefTtrxKA=;
        b=Ld9g+kfoX1bIot/7iJH26VOdE7TaOT/C9GuAH+TlCmiYOvOO272vmBskKpqsMN0UBi
         5XdQPe4crseaqTPa+4+byjLD36JlBurtzLPpw2+m5HxSY2CauK1IEMcwvArucSSgrcYO
         imGI8CKm8fIwp+InuR6wMTWvI+kHgC6uwwbvm2BIR+mOZqvDT9h4FX0SnSZynSBnIxJO
         AVwITtn3ew9Khz0uPiuyd8CWdut492HRW9swhOt9Cf69OTJr9Dgt9FO4G3jbhpkx1Ub/
         oBeAdeCLrudbe1DpDg2+xogFzL+iJqsH1TWqlwmXCVh2W/s3e/uz7+yhRfCTNsY43yDM
         2LAw==
X-Forwarded-Encrypted: i=1; AL+hErE3ceKWUUJDr6w56aO6Bn/JFbrrZKUciHL0+AUz+9FxdAFOhBMe4XdG8AuzG5WGtWkhJ6VRGAIXWyJTCRYcP04=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w1088Jk7ianvfjtQc7j+kDZ1EdzPAUKZWwLm+h6wkDNvxDvB7
	XSMnWRhsG/Bfy42f5jO7g9HjbOHggPes67+YDPfgj/0TyUzgKNxX5xbgvOS/QHRqx/gaFiuCeiF
	jgRC3zEuPle+2ybw6WaAgg14siHtrQtY=
X-Gm-Gg: AYBFou0ImlTCi0PxXpiWR6Yxkf4UUVTqBIo/Hgq3Xw7IbwhRiy9Sn7oa3SFao68E6+l
	PLNg3V5cPKmSIXfFrKNmp2fbyXxLdBhzhdyO70KSsPgP8QXuN7jJXkKljCYn9jmWZxr4c9PPW6u
	fdZVz/AWSmz/5qk1TYhNsSXFHoIn2Zpt+du7nSEyRhRDrH/NylXCHjYJZU/9AFkhC8ISIBrMxf8
	vjZBRxA4Ssprk0TWpJW+V2zRW0qsWfI1irULzidP8fLrSesIhk2P21QP6sy7/pZr0yPFyxUF+zz
	IbuOY5jwXBjAxSmLT/StKjvlLdY7wKxL2qDBVvzbPsIIlV8ZZggP97uNzVCBnspe4pWs+VlP65F
	2oMfwv92LaRcDIFf6jbXJTr2WiQuZoCRRW7ONZkIrAigKBc1pJ43gQeT/sIIGzoqPqXfiFSs4zq
	z/fM+3wcDeXRFsimz33WOjkDlg/eY1hbe8lUuy8muJo0cb1oOdFXUSqcMQzlvnV8R+uhMduYqPJ
	B6SBwSuEheq5tE0q9r1iWt1netg5I/mMsNGYoIveISvfOVDybnC48MzhHKkvQ==
X-Received: by 2002:a05:690c:4804:b0:8b3:4022:d81b with SMTP id
 00721157ae682-8b39281e93amr14763687b3.4.1794307950215; Tue, 10 Nov 2026
 02:52:30 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local> <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local> <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com> <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
In-Reply-To: <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Nov 2026 12:51:53 +0200
X-Gm-Features: AclHuK_OONOCVTyFsjjRyXe2igkmpzvumbiGAvSGjLyAIyl_gOSbE4gZk1U_Cc4
Message-ID: <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:50=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
> On Tue, Nov 10, 2026 at 11:12:02AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2026 at 11:00=E2=80=AFAM Bartosz Golaszewski <brgl@kern=
el.org> wrote:
> > > On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski w=
rote:

...

> > > PS: is there a way of using match_string() with non-const data?
> >
> > Why? It's an input parameter, it returns an index. Whatever you
> > provide will be not modified.


> What I mean is that the following change

> +               ret =3D match_string(merged, n1, sec_props.array[i]);
> +               if (ret >=3D n1) {
>                         merged[count++] =3D sec_props.array[i];
>                         sec_props.array[i] =3D NULL;
>                 }
>
> Results in:

> drivers/base/property.c: In function =E2=80=98fwnode_property_get_names=
=E2=80=99:
> drivers/base/property.c:607:36: error: passing argument 1 of =E2=80=98mat=
ch_string=E2=80=99 from incompatible pointer type [-Wincompatible-pointer-t=
ypes]

> And I don't see a good way of working around it without doing:
>
>         match_string((const char *const)merged, n1, sec_props.array[i]));
>
> which is ugly.

Ah, got it! But why is the "merges" char ** and not char * const *? I
believe that will fix the issue.

--=20
With Best Regards,
Andy Shevchenko
