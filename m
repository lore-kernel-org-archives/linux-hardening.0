Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301961;
	b=zDxetTgC7zk4wED9UhgwMPJXvJs0EwQHfgOOdwclRl4QaTyh7hx/bL1HrIeEpP5408jM
	 vDw0Da2lMLvbUNydSNM1Fv1aM66y+FSGt2m3+Q8d61raXJxc8uKcDhJLnMYN7Np3vFnET
	 +EyCDAbbF79d3L7pF5+m+qzXKYAM/kI5NBJ2twv83wcvRmrWe79L34LLPWzUZoft05mqy
	 M9nLWJAiD10t2IVeNCiOTKL/DMg5DeZ4XlGpnUSQ5DLTXMjpF6X03Dt32yn0sHMo2smZU
	 7m0CT9FGU+uw0XclNxRK6aNiFMT7Yo5nwNRdQ8U23emPiQkMpjalWr5S6nASgpVm6QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
	b=erlKDz07E4p/WPwyauyREWDokDVNwJHr/ZHq4J4wZ4QNh02CRciHJFpxg5YAxYOpwW74
	 yb3dzOYamBGyOSqNjjjZLtAe9fCj6ehT3J2LWneW0iQzQ2eR2v/u61cL1e2LiED91YqBm
	 UfLU0ScBaRmzjR9qYTY2bOYA+GQIfh0Zz06HVLuGPg8SWbku97PoM0zS2bRpOqxNKwUAi
	 ym7JDWIEdCF3666aI4FNIONotgRHhPRMoLcOm5RnRja4FxlLWpwWcRvVZyzV0a4miJ9sn
	 2Xi7orpgPNQ62GpLiTQF7t4n/5EY0RrH03S4WC2ZPuXMMQ4BfOo2X03/ta1bcakklpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXKLOI63;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8A606A32A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 09:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC8A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXKLOI63
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b30477a320so13255767b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 01:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794301960; cv=none;
        d=google.com; s=arc-20260327;
        b=e0GoOUr9hIiXT2zx8ncJ9VHmX/jFpqdLA+8lzXb5uB3lyI06MmfGMZqw+kzx1OV75Y
         91JECkXJvc0fQwIvg6CK4O4roymTCdahA4Zq9qV5lLvQ5KNyIWmZ/j2GFYDoJ4ULN8gE
         3bduQuyNL5mNPCxAs4+30wtd17E3NGmBOcjO/+txVwiJqWtb703ezLxq2p5gi4ZLKe/K
         7nLTLbsixfcOJ1jKFK+gMUjE6Mrs0QEO0Xba4OCEzh5PwkRC+64EUMvAP/OkBvJzMRYQ
         2n51e6VaFdDrOnJxzfmBCQ7nzjGEfX4efX2wMs40DW5pXfZ8pT2XEcZjRD1iny0WQ5sp
         WXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        fh=ayEzsc+7hQBvyN3xiEJmGcn/zSbqeG0EuI6C/89g1MQ=;
        b=CspZSQu3CnZEhJSYkJ5LbuJbxSLpuoye7scRWXU3jvVsXFVEcfrbEPbtZ1a0TJb7n5
         ayGsU+MXLwWhmw18w7ikVGvh1V9lYV6iz7+A4kdb5ac2aEabqjoXQ7x0XMZZUVBT/bMi
         GPAlDiGVFPL/94wZpIimg8KKDjhXY8s4UR8f5hFynEOLXX247zi4yr4qcpdvK6yCmkdC
         SFfCxtU3oZm83lxDcgTRZ2VV4gv+DqQvHCkKFvYUcO4uSJHQyLX0mHn2xoGPeRxyHNCB
         8wUr+V5Lx4XZqi4MiQG1rA4+l+URJS+ohEohdGFYdi5dr74STU1axV1gkzFFkLNsj8pe
         mJ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794301960; x=1794906760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        b=zXKLOI63QCscfYZHZY4+Myzicd3aopoC7ck6ONm/yWOwDd9HV1/45+T4CD9+NQGcTG
         SlNX7swBaKhRgHML4wPGgoeSBIi35vGBbJSSz4yimhH3cIFRhcjsbCyjb9Uu/ORVkgD6
         hsv+pqcRKb0uHQ/jo7P8JQs3ZK6hvlZjj1oof/XjmAN9/VfK/6x0zq58UrGVPVenk8Du
         3XU4RtAafPfiVRYCDA5qoTR7c7CTBlHqK+BsdQtwJe7rfa9Kr0DBbBdYZZ3bpmYeqIPY
         93hSDDNLGk1fNgdbjh4PX7UbjOYPTKMD1Lhw4NO63Yj/9bYTocSAjc6Wvo5ijvVNmQ+p
         jmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301960; x=1794906760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        b=2y4fVvRVmbJ8bzmZnZzvr17qonnpRK6aFsnO6/Gxc/HQCelrDmH/PVJsoEbYT1NySb
         xcHE/tbQ07D/2PyQ6cjxU1Of0gLz0AThbqdOK+G05wSzuI/nBT5t2y0v0OzLs7XUWw8S
         Awwkwe+R+NLg9Ql7pHPyLIi+pZVWcq3hqRvXXLipoG/nAD37UUpT3qVuuqohq9JHXBt4
         lK9xtGvfs4zUbCch32rX4mxEm4fr1SqoxftDu9ax5PUa7e5ZqsriiRrlindnpocDLucp
         mvO2QVfK2/tVtJMJXXqCRGcBmPd/ijzznrX3ymX18JQ9vWl9q4XqPOOzNGxDbFXNbZh2
         ptlA==
X-Forwarded-Encrypted: i=1; AL+hErG4Atg8KNZpi6Xeqk2F4zIXVixPNPzbLWA2QqN0ioDdtD4yR9i7HqbWodrDH/pzctIPHvWzioNXiSjl2dhN0PY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+ylnYfqYrkZfV/idTVqi8cM1t1s91XoZbuGfQWu8VbCT2syFB
	Jvtn1o+NgnnPFldonCSBkY0XKtiPtH1FLHYVCKRE/Plc20O+HshZebjKaOzUTKsV45hZN4+ELDM
	6rbcHEl+4lBm05exkZn5wgE9n9AE7QoM=
X-Gm-Gg: AYBFou3qMr808mlgs+PFIMtqU8PHgC+GX5ijrCQfTU4LUx3j+1bV+lr+nemU4mO9vk8
	mD8m9bSq00cPfNpoHCC9jTIDcdEZ9QNbSOyXOjtbzEzUJo/LcZreg2/M5D7HD2nmo6n+1Q6JW1z
	Vv2TTxWLKGQImTcAgLycvSMSJe7DLnE6yxrM4Ni052B2mhTZkXDV3uMgoswuvEPi0oQduBjgdNd
	dKOdnFSJkcHPkX/MgRRjn+MCr90JwB1p2KVOkgqjfT5ml+XAhxloP3zzVWntwjkcOrXNmuO0N+u
	HX54EwywNZ7YqN8onqAormvMtsdA2oKuKD8vWtVqhmnoQb9W9P+i5T0SCvoG9jYRB+trUMQ3zvU
	VvWV1QKzQNhjUPjYEt7W+/ZhvOkf7NzgFUDOTqBMEqJhqXQqtUFq/Rr7WR7td7A2Pl9xYT/Y/mO
	wKH24P41Is8j/PSS6W0BDf0t1ZI/gsd7Z+Wq7WfNyoyJ/FuaK9Vq93x9OlWcw0bPuQW0e2vRDZl
	bag54WOucRmVqJqViZXvvlD4LDVH5ZlvtOqpwWd5Rm8jOjJcbKI0+uUZgysG48=
X-Received: by 2002:a05:690c:1c:b0:8b0:a01e:2cc1 with SMTP id
 00721157ae682-8b392bd3a6bmr12222497b3.53.1794301959730; Tue, 10 Nov 2026
 01:12:39 -0800 (PST)
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
In-Reply-To: <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Nov 2026 11:12:02 +0200
X-Gm-Features: AclHuK-j7UjC7_2X91Fl0h3tqgy10rRsGsXGtMX-1tGj0PKndsOn6ITWu7Xe30s
Message-ID: <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
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

On Tue, Nov 10, 2026 at 11:00=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
> On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote=
:

...

> > > > > +               names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > >
> > > > Can property be statically defined somewhere? We might want to also=
 optimize
> > > > these duplications with const variant (here or elsewhere, for fwnod=
e generic
> > > > path, I believe).
> > >
> > > Please rephrase because I'm not quite following what you're saying.
> >
> > Can prop->name come from something that is declared as
> >
> > static const ... foo =3D {
> >       ... .name =3D "bar";
> > };
>
> You can't know it for every instance of struct fwnode_handle, so the
> answer is: no.

I believe I misput my question. If there is any potential that *some*
of fwnodes use statically defined string literals for the property
name? If so, kstrdup_const() and friends may be a better choice here
to save some memory (which is getting more and more expensive these
days :-).

> PS: is there a way of using match_string() with non-const data?

Why? It's an input parameter, it returns an index. Whatever you
provide will be not modified.


--=20
With Best Regards,
Andy Shevchenko
