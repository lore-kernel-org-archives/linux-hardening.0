Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EA1A2658;
	Fri, 18 Apr 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017281; cv=none; b=n8zqJxLbxb4W4UhWFNBXSLHQ4kbxXOQyZto8oo6QzGW4Rv4ZrjAyqDUy10BHe6cHeEVOfws+6vkQ3zwORiWPBz9lOoWIv9XCGNioZDD/LC91DIJSbn/AXrLukkh7dwiJcWzhx+h+4p9D2Czxsfgcyd3sGP86XZGyiqlFO/Ch7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017281; c=relaxed/simple;
	bh=VQy0mOHcY16VbiuCnUNEHdfMlg4Hjotj7KFV8oi5pL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPNL1OCqkoSQbtG4CYOYQd8ap4Mbnnlib9WXxH6dBzukAYw5ydZXyIPwWRtsFw/e6P5Kk27VskKYtD/A+0k617FwDY8RCfaIHFBJ61mD2fgzjugA8Z+pwhXW8NEOwaNkaO1GdIe/dSf/PaDssi42vEjTjLvqC6s2zt3P7mrY0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE5w0CiF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE5w0CiF"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf1d48843so20123711fa.2;
        Fri, 18 Apr 2025 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745017277; x=1745622077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQy0mOHcY16VbiuCnUNEHdfMlg4Hjotj7KFV8oi5pL4=;
        b=IE5w0CiF58pQbpPTuhMRSWmf1dEK8w+gFf7VQkf3C/FuVY7MwZ8tLq6jjPGUiqlYPS
         gYE4lBvB2cpVHCAcL0fpaFwMOAN73dzf4GBKA1GqbBwrTcw0MKLaRi+VuQyajBSNcvSY
         6hg1DyF63NBmOeQWfkZT/KDDnwuCfnKt3eMFmIOJYyKToxQErDin0M2yLOF2BmGEathM
         fQkCzf+mlvpGze4NosIPMeGWMhd/lVcUpCw8ebLDuExDboFvLpyfFijIVQ/O9cJawjQg
         5rBMn6GtzU0EZ3sujCF/cD5+G+Ypo9GqQyuiGd7r5EOu8GOghMQdZItNiEV6gah14/rW
         bliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017277; x=1745622077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQy0mOHcY16VbiuCnUNEHdfMlg4Hjotj7KFV8oi5pL4=;
        b=oLvgzUZvzgtQJNT0ku5fllDHE3j1EgTIsLE51tPOYkzGdioSJhkXDPK7B5cGIIXYZZ
         aRxCP6cymOHPxj6ekOHJcElOGNf2KdeKs05j6vBsR+rc7AAst1Y42KOSzflz8o5rel1d
         al2tQYChN/JohCKFo/LImtu4FVIt0Dhh25cFPyT8p9hqy2G8tJfxWvosHgiUkxUOB6Lq
         z+kJ4GSMuJsUWpVg7OyjuGDQ1CVYCzPVf18vCMPN9WXlsfJlTg4hf23FzanaBEwq9JUK
         3oIe2Mh4fRAL7kU2bDuOXO+PWq7ZKzfPs8TjBYgnva+clP69G6jWnZ28bl6vVdGensN0
         c75A==
X-Forwarded-Encrypted: i=1; AJvYcCUD4Lw36BeLlJLYjqNqTDSXXSKSGMktVbJW9pQniYQ3a0qECX9vLWxIpm0nCQU758q7TlGDd4aEgXYut3Y2@vger.kernel.org, AJvYcCUrNTP6oTcqJdGOjZ8i00edOwaJg+wJbg/6vwislt5PUxatzS3HH7GPbzUsU6LJfvX5RFYq0/DS1yilb0tvyWrO@vger.kernel.org, AJvYcCVvRvyg5UYmE1yqYtPmKcGE143OJ+b8md3b3FjaTA5dpsDxBsjpP/tZ3CVYNC8qwWbVWcT8DP9IY9g6jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cZ4s2/iwhHtVcfrhPmt3Ww0OeX7fahHb1iLWUF1yzuS9QAiU
	c4GxK12IC8l4CiRYue9Z+qS0ffJkh0uYxR+rfjOaTVuNb+APJYHzLfY0h6DogeCnGitYHTJcupn
	bfzoVnf4Jd1b44DjvnMO68nCHobuWJw==
X-Gm-Gg: ASbGnctxAq+UttX9WAdXoAsyDKr1rCEdoRLjnwkrCoOI5P1YCtioVW05vQ5l0I6jXDl
	wk0LUl3p2S/BMlUNgm2dFOVRf+NLWYrrip6HfcDpUa5PRbDBLWrqlJhLla32FtEp/faPy+ohq/I
	+NnQkk2ErYpUy9Q7yIaJXCd2z2JfAtLYTDNh4=
X-Google-Smtp-Source: AGHT+IFFJTxHPf+5+iXd4c3XocplOZE+gYZTmqAwnMiWmgDb0xL1UfWTnq5s+7K4B1jUk0E4pd13T5jtylfmkSUIvVE=
X-Received: by 2002:a05:651c:19ac:b0:30b:f775:bae0 with SMTP id
 38308e7fff4ca-31090559978mr14231121fa.36.1745017276927; Fri, 18 Apr 2025
 16:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417192054.69663-2-thorsten.blum@linux.dev>
 <202504181322.5D3B93E93@keescook> <ABD8884A-36DF-457C-83D4-49F4F63C339F@linux.dev>
In-Reply-To: <ABD8884A-36DF-457C-83D4-49F4F63C339F@linux.dev>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 18 Apr 2025 19:01:03 -0400
X-Gm-Features: ATxdqUFOZ5fvGt_IXXw9Q6D-_eoT7DrRF9bpv9M2IsYXr8gmnLcbrV2Ee9atLLM
Message-ID: <CAEdQ38E4Hks+m=srZsuuu7g8N2z_hJT7oxyF_Nz3MYsm8wx9YQ@mail.gmail.com>
Subject: Re: [PATCH] smp: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:11=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> On 18. Apr 2025, at 22:23, Kees Cook wrote:
> > On Thu, Apr 17, 2025 at 09:20:52PM +0200, Thorsten Blum wrote:
> >> strcpy() is deprecated; use strscpy() instead.
> >
> > Are there more strcpy() uses in arch/alpha? Maybe do all of them and
> > give the Subject prefix as "alpha:". If not, the "smp:" prefix is likel=
y
> > to non-specific. Maybe "alpha: smp:".
>
> There are a handful left, but they're not as straightforward as this
> one - so I'd prefer to keep them separate.
>
> Could the committer change the subject to "alpha: smp:" or should I
> submit a v2 just for the title?

I'll fix it up when I add it to my tree.

Thanks!
Matt
