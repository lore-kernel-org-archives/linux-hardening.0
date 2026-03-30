Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081E393DC0
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905985; cv=pass; b=A6ofKO06T4kSy/KCsK2ErT+AELxo6hraOdUYio8QLlghOxMNNGfUf5mDLIpdm9+f93V8zAskrqigFU5siLowUmTEm0ICOadMtcR0iEjFIlqZlrpOw81WkM/B0mU6Igdc+e5jxvhTvXbRliLsXuS0Nv+Z4WQWdN6+EizXDPB2ajc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905985; c=relaxed/simple;
	bh=ALadY8NiPeRg67/Y2RfeQ+XYm9LcWvRmYMe+mGpRcx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOJUZym+yHKZHL5rtd5jYSCEei4on0i92aFfbUITYbRgpYYwGy9+6hHZovUgjWesdYw+RYHmEbezxb40z5T8c1j/FjsZgtNN6lHF1qIMxXsF25aBlNlMnQbT9CTeoBh61H8wgLkwDX4nvHOO0LSzFQAsbdAVvz0/XyqQtt3XUOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfzRETAx; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfzRETAx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so3613533e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774905982; cv=none;
        d=google.com; s=arc-20240605;
        b=N92bLPZR7EPPUoRC80knRFHXtkjlR+WtL6PT2zXj7jm+7L3JygHiTcjNSVMQPPbL8b
         Gx+ctnOVhdLKKsjsu72EH1mfqB8azrNpvZhzRf5GmiWI2D+DUBP640m4DeJB7QYEZMzY
         b3C58zswCv2d7e2QKon9Am8r6SEDM8FaTPnhHOuDBFt1mlSMEqrvDzZii/UuhWVdNm/A
         1tHsCspprdrVp1kz2sVYrEhIG5YKQHJjKBFeh4I8C3nrP/0rdDcc/aURI8N7jmk6MEnR
         ZOWPBfVtZBzd3Q/7+RA8MW6a+ABTttdIzA+HOjo7K0r7PyZKt1QwAOjmMhPSsPs7hzl7
         PuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPAzBhOfN4niGeqVshjASv9GN/8OjdJexvuZ25AJ9og=;
        fh=jm5EcKWBjIJGvAyNcRlNZf0Q6DKZ8VQpErUL3KZjS5U=;
        b=VWawOVt0XeY9eL3fWV1stMLf9kYaeC4B92UcoWtqmTQWcaIi/SD/J49IDgvG1eC5bt
         vdVnGSh3RX8c2IUyCvDnDWuKZfc6x+BQAZADqtlIhq+BtC2HtCs0t8HTMVO7ukEgiMuf
         Ak91Zrbd2s6yFP4TNqvicZh16L9I8K4NPsKv3dblWF5niuR1LfgpDoXUotwj6oH2+OEX
         a58+6O7tdgVZh8x1j24MbSGdAnQo3jgnAtYpVpLmKT8Qo0dFC0QRyB3Mw1xTk9yxn69g
         41eV2nBQmOK0RHPzXR9aLqdeoIUabzHm00YR7vzSP3F6eHePbf611P3XEX0WZ6pI6LaE
         oLpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905982; x=1775510782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPAzBhOfN4niGeqVshjASv9GN/8OjdJexvuZ25AJ9og=;
        b=sfzRETAxmRNB6RIrWtR3AaCudc41FD4SjiudPZBXc5r9tt+Cyof56KeqZR5+fs1AwR
         bNoNFcdJQCARo6r3Ao835ntg7kUkHt8CnseC/POBJmoeG5ZJVI98fjqx6Rukai93eLB7
         wSDvaHchivcx0HDwus/a5RYqcWVAfRfyrTedD85HHiWuL0b9e16OVPYulGtGjQhE4K/N
         2b3nbOxYoLpPt9bRgbxYJvN1E//D4MSnf+LWasYoaIjxzQ31Z0IGPaeTILNZyL7kiHlO
         vKh9DAfEf21LJCdBFDOhzBpn1i+qZG7ZIgf78voHt13DZRj3NTi9R8VibaCO0QMIqGus
         EywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905982; x=1775510782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPAzBhOfN4niGeqVshjASv9GN/8OjdJexvuZ25AJ9og=;
        b=Zq8IxWZD4DUh1R3Lrc5hxCiZp3qQuhD06ekXw8GNcunYgpsPl7OiCROin6Evd7yCZd
         HUTBDnHttuAbyGWcW72U0ATrPp/siaeI0LtEgjHtXZj10meFB5rdebEyI0MO2IhRYib5
         WhqCMXGfcqDzcToZZ0hEOCfhxGPpG8oAKfmA5fyVR8nqQ47FZ70g+JSHURUnq5FLG2Yq
         vtaBWO7maCytSsezEuSFYgXTSfNoue7N8anzO7DbRU8icO+FNp47YL57pqevFchosIA0
         vPAkl1QdsykckWro09WU6auLBrTfOxckQ8GISlJXnRQ3uNrvCZF1macicNOV/fhX+/Df
         b6qw==
X-Forwarded-Encrypted: i=1; AJvYcCV2DT2hyrKXSv0Z7SFrX5Q6JjMFrUwEaJHdT76o2rnmQW/CeiHjf3abs01RjC/OTObxXD1aYpqyhAR13RMWCAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQd28Ke9MyRON2kwRdSjUG/jlvxTB5+ttfwUcXL5DDQN8gBJY
	3gvKWbZCpwTzZUKcIVtvEAGwPB9ogisZM370ugXAhlFJ0MwZ8GXqADfl0F8rPrGNbwx3XcbUaHl
	Y5n6xKRpIjO8wXSnXmPQ1cOH/lRsrmhQ=
X-Gm-Gg: ATEYQzxgahoBJk0RtWDSGghLE07Qsfblm5RU8HtCpmZlJV3pecO5q8f+gvy3KZxSQ93
	rckZNQNXkSZnGHfM1MwuJgQmPf56K7t7eccCxfkuPX21SX2SSh+fMrGimkzFzs59591Qazdw/KX
	oZvX/kMxHelhfhNuIqrhbsrbkZiUpSQpl/4vWZXxKcCMlTB/vjEyAl98NJADxEZGCiD/dfvhtuE
	VEsNArWaPhTtQ6gOtIhIpt3N+hXZ9sGHv8h1I9tE7lv8bTn31cwIEJTB8zxZS9xvk02+41FNUYx
	5lrSkl4r7aibmPgIpHrWs9haHd3f9cSKswpUxFGBHe7pNJbaLUMb18W2ApSl8uCRNLQM4CmvM02
	Fnct/FA==
X-Received: by 2002:a05:6512:a88:b0:5a2:a1d7:9ceb with SMTP id
 2adb3069b0e04-5a2ab933c87mr4481664e87.39.1774905981726; Mon, 30 Mar 2026
 14:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327024828.7377-1-rosenp@gmail.com> <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com> <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
In-Reply-To: <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:26:10 -0700
X-Gm-Features: AQROBzACCiKm4LcM8ph4sJDY8VwHMc_K0lfkvl9eMNSaPH5UkBduvBF9-tz9z-M
Message-ID: <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Mar 30, 2026 at 01:49:36PM -0700, Rosen Penev wrote:
> > call if such a thing were to eventually be introduced.
>
> Oh, hypothetical what-if. Yeah, pls drop all that gunk from commit messag=
es
> pls and simply concentrate on why the patch exists.
Not sure what you mean.
>
> But you don't have to for this one - I'll massage it.
Feel free.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
