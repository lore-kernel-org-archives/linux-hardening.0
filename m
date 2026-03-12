Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACF2741DF
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274375; cv=pass; b=KM/71eX2jygPfz54SlTa+8CHgMabbZ7bBj9bzb7TvqsVY8qf6zoJtBzvvIcZnXy8ZYvVk5kxjJcs7ZNW4XFjwSeJbYBI+g7KCqkhb1BgC7J8swFxixTWJRAyXPu5czZLoKY9yzWXqLGlpTE6zrJKig3tXpEgLtzxUj4arVtwT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274375; c=relaxed/simple;
	bh=Z45OterBDP2JSXE73eWoxcqRXimE3kZG3qq1BZ+cUOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIlJeJjZY0pT4yCMQi60UMJtVVbYb90REfSSrSi22onlVLIpXRvqnBdTXijP100/VeVA3y6/Pa2VkqQVwNIdo0YW8JcStxUxSSFc61ONJQKb5BQkJB/qhhvgfP0pjx9AR9+EMF7ZFCV5asAxx+LG2NQXDj9e159DNiR6JD9PlYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ3aR1Nc; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ3aR1Nc"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b96e579c0fcso70223866b.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 17:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274373; cv=none;
        d=google.com; s=arc-20240605;
        b=F/AGAIvg0y+s4YXZsE9wt/hLSBTJLmjb9hgyMb3gJ1xvqpYJlq1saExg2nQYL/Ir1r
         n+RbGNKUVYMvzPS3bQTKhepSVzTH5pOY2mWXBOn+a22MHwo1QMRT6FZtesZEvisVDjlG
         iWgH2MJlRmvEgUxZ8XrXvxOZomm2QKB6CjM+pFBogaRDNAX+iTlDddoUfDloN8q8JfzA
         6Ecoz9VY9NSFoy0Py2iJN6XVia+U7CS9eiaiPB012YWsLxd1ps0CSAdoPy60GYcPzV7Y
         4qEYNDXF78aaevLiXssu9u+EMyVxiTfQbtqTiezL8Hu7B6rrbrgn5/ljnsAcpfcQXsuF
         G6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niNGb8zSNOiZi33GG/eK88N9FqlVPDb2fO/vkduMi9g=;
        fh=QzIZHZB4sgbiMg+2MuXdzS/8BFxgi7+hWKdB3yg9zfM=;
        b=MVpluTWWzphFP+vwBDVlj+DpzxE9u2hyg4n9KNz+ULnR0YERb7bxsNvTAidObs8MAu
         FIBqD9eG+XQU5EM8X17QCWA3xdLyzLtRyDA+YuHoNNo3R6UgUDnkSYhCZToQ+a9rv8x/
         1MQAiwXjQu2ekAHcmmoFk10q6UA0Ew7UkfSvpMVsKSSq5wsum4b0B2vFQUnqLlwoDDfP
         FJIN95HBEYhfIvq9Kb0r5a648jy0DeMwDAB574a0Y/IdbmE3FEbDUnVq94FNldjRteVK
         jZXHUoj8sqTueCGEtuRzr8JKnTMN9mBymIkWnQiXAg6dxz85qGXpEB26EaL5lhHBd02a
         BX3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773274373; x=1773879173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niNGb8zSNOiZi33GG/eK88N9FqlVPDb2fO/vkduMi9g=;
        b=AZ3aR1NcSvKowoC7vCMUbwYhYwkOHWk9/JlEANA7iUPNiqriKekHO9Wb2A24QF0isy
         myoWAKNlnbhiWsUQD6+PQkESuKz/hM0rEc8IkaQFoFCA4NeHb5yOJ2OYPmiHAS9foxwe
         rG9kS26g2UgwBw/yn28FDC2Tw61b+OoAB1vzGD/Th5Om/HTdoQvgkcNnaqZQ+wyT0Tr2
         9VWLEks3NlaKuTqXzDo6vll1NB61aMN8bVnFSg6K7kX4xw8ePQdE0I6mQ3DqFNa09EW6
         1vntmo+zyEAE/+dMs3WobCRTOEOjuUjs8glqY4MpsrUBMkgqYU3x7RkXHIAYarBhQ5gP
         hS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274373; x=1773879173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niNGb8zSNOiZi33GG/eK88N9FqlVPDb2fO/vkduMi9g=;
        b=mMhP3Fx994gq/3LaK5LiTzRSPWh+T3tY/xfo0k5OqkXrXqK811D1t9F4xMddyQCwRa
         4s8BjQOsXYK/Ybd3jZTeYYn3eurIU1lVhFsfENFFMcsTeFOywM1KVjS7NGZQJsAiIaUe
         8Fh1NkubadpUzFi60sBXJ2vQHZHRiVQSs5V1KyTKYGnCWS92cO9xXjAhjCQTQKfZraWT
         W2aQYoeQj6FuK/gEx4S53iolYKJSJXEYYDurHkxXQjxTpkbSO3mia2eBxZZkyEsMmG87
         TkzcmrXw3I1LYjRN/QUGitbsOo1nxcMmxfjCa/9s66ZIa7knUW5YngcfP+wzaglWNdRB
         EqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXyJZmFABgSeiGQulwvya3aSlmO5bG0ksegUmWJRXDyJXov3LY74FWjUIW2Ina4+AIkW7+BGrV2IFE+ka9BWMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycF823prHAnmerD8jLvPEGiywBzpqAaULHvSstGdZlCyuwlzno
	8SEFXxBdUrU1o+aL7ZIOQpIwPLwVUs/I6cnpdQy+hpR2ynEq+cf/vPyLLClOefIK7obGRqy+J2T
	f83puKWqISo88zkpCnyzu42iN8ICYg08=
X-Gm-Gg: ATEYQzzJZTML0LCkvBkzoKoDf30i/jK/Etx055/UKS2WPjoDgFeSIKZxU3K7iSnO3KL
	0/XPbZrjmCIMUqNIXaTyhuXKgIB6/emuykqrNAlvQS4vcMFOxyzsTSIXOJM/KUJw5YLWjgNrxyH
	dbZjxBA7Do6e3FkHKxNhwedGXUXCQ3x5rUbFcvuQtLrGg305gCHafxWhItbMur+xvsbfxJYhblJ
	ztK3c3dqrmkQqnKwc2qNBPyUWRSeGOldxrOZb5PqrXEnDVhhyZ2OSDu1WWdOhOk0FZ61vsNGnFQ
	Oo5hA25RkPz1tYvcMW9hQMaqO1VUHsD4vg71D8EzWNOoQYwBjoBLujxXBQi0+rk4znNq7z/9L09
	OQDMqPgdzJj6fjBrl
X-Received: by 2002:a17:907:9307:b0:b90:e278:a09a with SMTP id
 a640c23a62f3a-b972e58e86bmr270124266b.55.1773274372542; Wed, 11 Mar 2026
 17:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311232347.18257-1-rosenp@gmail.com> <223e0295-1819-4234-90d9-7db440f25be3@linaro.org>
In-Reply-To: <223e0295-1819-4234-90d9-7db440f25be3@linaro.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Mar 2026 17:12:41 -0700
X-Gm-Features: AaiRm50BtfKrrZAVcIzzrO96lQ6VMb4xLc1b96uWGTVyrN4JfHuvhY5_y_RqJhY
Message-ID: <CAKxU2N8_ZsHR9Uzpw=XbnsFiBoY=ai7AZ2_LbEw72ouCVwKb7w@mail.gmail.com>
Subject: Re: [PATCHv2] usb: typec: qcom-pmic-typec: simplify allocation
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: linux-usb@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:37=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 11/03/2026 23:23, Rosen Penev wrote:
> > Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> >
> > Add __counted_by for extra runtime analysis when requested.
> >
> > Move counting assignment immediately after allocation as required by
> > __counted_by.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Hi Rosen.
>
> Thanks for your patch.
>
> I have the same feedback as Greg gave you previously on this.
>
> Each line-item in your log should really be its own patch i.e. v3 should
> be three patches
>
> [PATCH v3 1/3] Change kzalloc + kcalloc to just kzalloc with a flexible
> array member.
This is probably the only one worth anything. I'm getting requests
elsewhere to add __counted_by though.
>
> [PATCH v3 2/3] Add __counted_by for extra runtime analysis when requested=
.
>
> [PATCH v3 3/3] Move counting assignment immediately after allocation as
> required by __counted_by.
2 and 3 as you laid out should be the same. 2 without 3 breaks runtime anal=
ysis.
>
> Or something pretty close to that.
>
> There are several reasons for that
>
> 1. Bisectability
>     The ability to more easily bisect patches.
>
> 2. Logical separation
>     If a change deserves its own line-item in a patch
>     then that change almost certainly deserves its own patch.
>
> 3. Mixing stuff up in a big patch is confusing
calling

 20 insertions(+), 25 deletions(-)

big is wild.
>     I look at a commit log and see lots of things going on in one go.
>     I as a reviewer or say someone tracking -stable and deciding which
>     patches to pull into my tree can't look at a patch a "just know" what
>     it is doing.
>
> So v3 should please
>
> - Have a cover letter
> - Contain three patches one for each logical change
Maybe some other time.
>
> Oh and reason 4 is the most important !
>
> Patch count bragging rights !
That's just pointless churn.
>
> ---
> bod
