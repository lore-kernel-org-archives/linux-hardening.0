Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F433376A9
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520682; cv=pass; b=iWWhQM9rqAXkE9I++LkO+TEPODd+wOGJJvQk3eka7tosNB6DHtqu7FZMuugN3J/uqhthNt63NuQTRL6E7zxDTcm/K/1dTvHa2WTb6E7ia31OrV9M8iJ1F0Uk23ybDsOK7u5a5XqwLJXCqTrgzIZ5U2DcxHSB38GaohkFkozQ5HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520682; c=relaxed/simple;
	bh=b6U1hG3nrOVFz0ecG5N+39M6HPtyrPXlR9zj9WH7HqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV8IPsn49znt39o0CUGGtbE9T++E+8bzTig4M8EWikjNrwxGm217ROUfhQmSn9dxwmbZ+ILEoRZa4De4cDIbLasCDaLH8h3XPq7q6GDbzINsdIljgdALy9hSBoKIwA1pAy9EDRSMOfYTy7OXu2zCNXDlFSDlwAJqgun0p6THPsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649e456e8a2so1057830d50.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 09:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520680; cv=none;
        d=google.com; s=arc-20240605;
        b=lxIc6euWsSXahmD7gLkfCFna5Ppbz243S6Bj8beQ5e8TVvvZ5LppPVMD9g6W4Nqfp1
         JgLKw0ROY/VlTpL6QLIuSPR8dY1dx0Nmbu5nVyVOO3qBx3KwEVkqKQ2/vESQCLlWgV7C
         dQiPAWnQM2B3P70W/5furyZZvYpnRvO5ugWE09k9I/VHAzmNUNGeRtUdpUD8N9HCsaau
         r7KD+xc8KNJCmDtuBno9P79ih6dQekU4xUs6AsqUPbfji5UPNtBoepKNf6mG0CADnT/H
         jFKtAJgiNlPGdVUYjP4uomWmQ/e9D6TZfoRATUAhH1JGTRmeIHDgZddldEzUG4s0NTQd
         eRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=GCfnfADMenCdj35GVzlSj1RLfLETxBVqx3iNQnVeu6I=;
        fh=ZUZ0t8SI1a1W/I9Y65dtup0sWEj7IT48dDQGoFAuULo=;
        b=DDaWGT4cRvXLBY+i3XOfyk1y2M7x0SwngVh5ByBfpkXN1Qc5XyTMVBCuIBvPtcjro8
         +V01eMAKPmcUK0chSuar6E8Ds10V6KW9ejwSwvEbcCYUfH2/K6GM7RAbApO6T2n2XyI8
         aZK/fpI+benMgQuauv720ZA9eSkHuWIRZgxrFpCHmDwaDWfSZYAJZQNqOWOcxFkBtmoV
         LC2g+/19Yz1398/xNpr/N8PVcAJ67mD+PUpm8eUSE1sO4bfwLvcA8oNnpp8eLOLTk5yh
         bmZZT/IpuV//CQygQpCzRgcr/I6mOpGg51hw5KUfJbs7QzxceRJv4HaMaeQ6pH9f8hxG
         FJbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520680; x=1772125480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCfnfADMenCdj35GVzlSj1RLfLETxBVqx3iNQnVeu6I=;
        b=ZDV4vJuomHqZCaIOIFo1I2o3xiw4nSSc15Y98Nx/cVA/M6wbJAUFiBlhRjjID2KA6Z
         14TcofLvzfiNGyqnp0onorXJnWgIGrNa9JEKbPqMuKQnKFlYJb9nN3a3oXMSMMxLDkVy
         R7GS17tdWyY7URGPR9dNHw6V0ge25Gz+HYlRq3n5RY2bQjgVObURlM4zf9/VkN0SWjR1
         0VT9xSMml26zfPxPMUqk+x5EzJg3EgZBbIld9InOiXV1+kSF7qrz49nMJnnZQ8fFbfuO
         Zh9gkJZZi33yHILmRXkpygyj/z7RDrCqSF9KF5g3EjP0GPnyPy2AsSGu7F0dChU7aVr3
         qgog==
X-Forwarded-Encrypted: i=1; AJvYcCXCUQ1Rd5O7hSwCs4IJhltehut3KzVXhcFCUhfvSqOG2+jCguw7e95/R9/ra4GgYKudyDNGuD0feTljvytNY7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4h+TD2fD7JVwi/ubCXU+dKmqAeFAAKW0/mNNtgy2npunow94
	rfyM2MNXJSF6RH3xuSlp1SA/uAqe2p9pD4TcQgQeJpfKCwPsLFHRXFfbPbj20cDOUthBo0ygvOg
	+3BQe8goOZZazItvJCUkLMPHB5p2S+7Gbd+0ULaT/rQ==
X-Gm-Gg: AZuq6aI84SoVftIaF+FfmgQw1My6wlH/Eo0fBxPa8rXeVt0Y2ONxLxhjRuBof7QbZdI
	oMNfXEZ/YlPWYMw/1t/D0cmQOxWbvxSFdz2zNceWkp/nKQAKRFpwJ0CgYqxvtwBtlZ0PDNwgXRP
	Gi4y2WusJGeyc6iq5vHvo6Xero4f3LXXsDGQYAi3S2MaGhyjYtiA+ZgGRi6gPIi6WL0bEA4u7Ei
	mEItTRzEHHPVSUQ5SArfou+ZQCQyNrn41L1dHJpaS0RqJaRR+9CUxQYBT5FUNU08lnkyRtZVmgJ
	+pG6HY/shSLTpqM4/x+gPUeu3UYdNVFKFkDHlkOm+M5wYmJe
X-Received: by 2002:a05:690e:1c1c:b0:649:c375:974c with SMTP id
 956f58d0204a3-64c55587d75mr4376174d50.28.1771520680340; Thu, 19 Feb 2026
 09:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3> <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com> <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain> <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org> <aUVI9smf2t7PvDF6@stanley.mountain>
 <aUV7kyjxlijuy5sC@agluck-desk3>
In-Reply-To: <aUV7kyjxlijuy5sC@agluck-desk3>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 19 Feb 2026 09:04:29 -0800
X-Gm-Features: AZwV_QgEIU-5ticNLcegsMRlOq6nRWIo8xAridFdMNrLj6Suwr-SXxpNMC8DPy0
Message-ID: <CACePvbVCwr2hc+gqUBWz++GKsk6+c97sBrVRFJ015jyeLkDbcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL characters
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, 
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, Malcolm Priestley <tvboxspy@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Sorry for the late reply.

On Fri, Dec 19, 2025 at 8:21=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> On Fri, Dec 19, 2025 at 03:45:42PM +0300, Dan Carpenter wrote:
> > On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> > > Maybe the flag fix just needs to be applied to the evaluation? Other =
op
> > > structs do the same. But Dan's patch did not implement evaluate. E.g.=
:
> > >
> > > static struct symbol_op constant_p_op =3D {
> > >     .evaluate =3D evaluate_to_int_const_expr,
> > >     .expand =3D expand_constant_p
> > > };
> > >
> >
> > I was waiting for you to send this as a patch.  I can do it if you
> > need me to.
>
> Dan,
>
> Al Viro thought this was wrong. His alternative patch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?i=
d=3D2634e39bf02697a18fece057208150362c985992

Hi Al, should I pull from your git repo
https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/
instead? I saw there is more than one commit. I assume it is ready to
pull. Please let me know if I shouldn't.

Thanks

Chris
