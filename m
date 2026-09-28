Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B484501F46
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633269; cv=pass; b=hFsffet08I4kGH+PrxhUJ3XPNIU6dkrcq2QBRF5qbOwWJdvTiROy/cFyiEipvAoY1GsjuabOr+MeTif2L4IremMDuWU7II7UNfvTSLZREn1b72zjtshohe3ph4Nfy5lgRLcAwa6hYuKj8jxNalJkUR8iiBvYU2F+gv8CFr0X9XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633269; c=relaxed/simple;
	bh=+BryhTGoiN9HbpqdQW7fneRPfw3ZcJwzXwJqqFDDUAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQn89jvXt3R84GCTMQ6ilLHMbw10WbTlPVXBO1ytKQvzWeFqlfrQUKwxdS3bl8VhWOp6rcro/bJFG1u1tJm9WoETRtqPzmDEUYvutLZq7bTzGFxCnNGp8jGIjefFQ0qIFwLVcDcKCEWEF8CcUh68blGIezVnFtOEDPiNx0AxLr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5Skv06P; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5Skv06P"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b3a6aa10c2so811801137.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 15:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790633266; cv=none;
        d=google.com; s=arc-20260327;
        b=Okh1bX3ubKnxusUV/f6YIJR4J09JsOl2Z20Jfhf9dOkMYGvWVBlL5spnokNMhRujvA
         zADC1KJtoRKJt2HIn69aZpx0ENwYqMrqqGBfD0xtAOi5SRPFSJ04BejyDJlMpBOD8zCN
         L2Iq4T0bVbqEHttWK0If+ChqpaF9qFvzhakFnL/5Y4Xk8VkUcee55wrfgox5rMsQU7Y5
         6Yf9fFFt5W7Mw/OG4cAVAfnWhe/0ZJx5v9agUkDrQyzYwhJgG4jk/Yxt9Usq/Cavz+Bi
         vI8s6JbVRFWO3e9HROGe16xJcvrtQsco+ibSgPHNcADDibCD4qwaTxwy1Gy1D1TN2boG
         LjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+BryhTGoiN9HbpqdQW7fneRPfw3ZcJwzXwJqqFDDUAg=;
        fh=u4Q3OUz4jEdPkn9DyYcW/oVff9zYFgVVRlvWDR8ByE4=;
        b=s7q4PVHsb0UADnK7FskjTx+PUsNluedkEjzjqGMGE1qnlVu0u9rdrreyJ9jLF9ptZ7
         nWQcoIOsu536ou1RbjEkTo1fOeeScfmUpz5XFJepP6pAZZEUBmxa/5G27LL5gwdNVTGX
         upYcqsPY9+Cpt5xCok0z46UOKzQUEystKkOt8mgrz8lhwUDoyTvo6gA8rFYBRCYPmAfw
         KbHk97T2cgQDSzw3de894TW7231vGjlekOr+R3mb/FMHyf0REX4HBktzFS0xiVXMyHzL
         66j3+oZH2M0uowUrK3Ymk1W8trvR0LPGMbRtwi/7mDigipgP6WTbG+u5sThzpp54CgQz
         1dlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790633266; x=1791238066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+BryhTGoiN9HbpqdQW7fneRPfw3ZcJwzXwJqqFDDUAg=;
        b=I5Skv06PdP80elAdgEOkV7u7P5IFmWePOSv8be9nurQoyTIkpv8H94neikY8rZnjfQ
         4tqVeM3HgJi6ymwkm46Up929kx0IfhfD7GXz14YOnlTl71KbU+jbi6p7UNwgoiL5dzki
         agiJ8kgWocCor3z31dPAAeS7DiTk4FPj4P5GQv0Nm8pD7jCtrUWmy1jxo4dqkJsteJLJ
         tP5zcWdJYFjnus+viEBajEGX5GHO8mFanZKdnWONKEMpmneGcAx2BVfpdQiUeNmU+FjU
         QavbkDL670yrFJBBSMnDDTy9nDoJvrn457jJQsoUZHW04B7BXerbwwpHgOYdBnT/JM8d
         h8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633266; x=1791238066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BryhTGoiN9HbpqdQW7fneRPfw3ZcJwzXwJqqFDDUAg=;
        b=sdq/YKACiUhvUL2Stq5m91bJzKuITrf5DQZ1TNehxAFT3GMY5ktVRwxI7y2ZtKBaHL
         HMrE4s0ht79Z8LSQODmCZXQe6qsd6mKst/Yk2eejN9x45ODMq+yCSq85ak874c7fK62/
         3E+SuaGbbr1sGuMusxuSHODaWJjweFJHkYzaxFKogqi4v6IWLjiAZc2wrT3GPPVBoDPh
         zmHYsA+59X2FiWVe0mzK88X2CRf5RFJRjRJOZyVoD4P9WAIk/fQdzHaYvhaDqUkrMHrn
         rSIKlSVLq+TF84cZNmcEkn4YtjjUWK3EAC+aYXqDMXgaGsatkUBn75kw/LR5GXDF/OfJ
         bD+w==
X-Forwarded-Encrypted: i=1; AKwUvBx6esw2Bwear8oSMdRBK8h78y6XsEYWQ8xXiOPnWY63iUh/UPM5HXfPL8bRighcutKdYsDUyQq5TtVsxOH5GF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKYewzCCWDTDYkG7vuTl/VxidYWl/F/RtVA3FuNVoKOjFzzrMQ
	ZZJ9R9vprY8H4PVElqwV94nFjBvHCOnwijWNFEJirfa36MCZ5bFwwaHoil/CpYgN2u0ZB1k/j7H
	ieOYwoeFE+gc9NVNRWbfdOeIhmvb1/o9Uen3w1T1v
X-Gm-Gg: AYBFou1+SQYbt5NBNreXuVmUpuaH6FzXzLo0ESlyuxv78x3Wl99v0kvNW20IJmydZun
	r8r8yZ3Hq0jDAknz+PFXRU1fNlWuST3ZPpViqSy+rGQWLbxCyT6r6+jeK/oDEKQ3wuBcZR1pqPj
	AyhpoFMMh4m8HzDq5b+4EkhDveCzTDCRzPtLqg9Cbw9yGTDlLMlip9K5vQwC8e+5g8evGv6Jtp/
	vYO0N3HhX9OKugnOg0zFv3G26pfbmvn86657XzHcPR8uaM/cuA6JMm2BITRal8/JRCmXYy+71T2
	hYcIjRDrLTH30+Nki7kP0LSeQaI1sRDSBbDF673fph+47v6RyMBdjNKXdzvhGzy+n/WpGGr6z58
	nP6kfkpeadw==
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2de0 with SMTP id
 ada2fe7eead31-7b341994431mr2105212137.4.1790633265847; Mon, 28 Sep 2026
 15:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927190758.609156-1-nikitash.mariiaw@gmail.com>
 <arrfZ5CYyLt0vwu5@google.com> <CAGG=3QVY_OGjSYZgJ8i8Nb-EbwHKPOvZsbqqXfcbv+Vvq_wsww@mail.gmail.com>
In-Reply-To: <CAGG=3QVY_OGjSYZgJ8i8Nb-EbwHKPOvZsbqqXfcbv+Vvq_wsww@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 28 Sep 2026 15:07:34 -0700
X-Gm-Features: AclHuK8nlJeFMJ-63_0sQ49qEkZQmIZd_Mx0rQvc5qKTUPlWeM5glCx-vJub4Og
Message-ID: <CAFhGd8r_JfpaBvjod+AA6G3BE5S-L8Gs-nc9xMXrxp6_tLOgVw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Use snprintf() to construct pin bank names
To: Bill Wendling <morbo@google.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, krzk@kernel.org, s.nawrocki@samsung.com, 
	peter.griffin@linaro.org, linusw@kernel.org, alim.akhtar@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 28, 2026 at 3:01=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:
> She's been marsheling some of the strlcat patches I sent to the
> mailing list. It's possible I sent a "v2" of all patches, whether
> there were changes in them or not.
>
> The patch series needs to be separated a bit because of Kees's
> 'seq_buf' changes, which will make some of the patches I sent
> obsolete.

ACK

>
> -bw
>

Thanks
Justin
