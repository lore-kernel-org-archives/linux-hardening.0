Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0723204C27;
	Sun, 23 Feb 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306638; cv=none; b=bzp7z/yxsTQB1oq4H0WgQ3i8qJRbKvao2X19UybEetpDwF3Cj3hAYV5xWgYqhbRSZZq3sljzxNa1paqYc6R/vTkRLNQwRlZDxLkTF7DT1+8ifWjvxxfi2Fp8DmSWOB+tpY46kTzVcdU1qFqI/u0Z5FmpQFmcY/RdwdAHPFRC0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306638; c=relaxed/simple;
	bh=r9wwqaJRtk9sOisVJ2iyPiOMx6Bdq8PHJKb1LjosIZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxbfVZQOs6YRosKTCpo7x56sdJnSTt1UjEsIQNKok2DV7JejQ5lNR+3pkKCEROYLVaGG0DvWqhZGwouUwdjcNQNx6RYS55Wyz0yfoVFhxjiTk7zYKd9IYZbuAusPbbsKstRyKRRc75s4mQA3aAEOreGH7zYyJCuCssVUMXnYqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iwhUJxZF; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iwhUJxZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740306611; x=1740911411; i=markus.elfring@web.de;
	bh=PbEif29t4SAIHbCmdiQGiPpEasdSjQ1egXOJVydscBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iwhUJxZFB6ap5DO7t+PvJt8NIVWkFJ8ass5I7Z0Rd6NsprE+ecudFC94v4MTNUbG
	 5qoHOPQ/MHei7dJVWrGJ6HMeG5Tm+AQs9RavyUZ3CRJ+nnhCF58iuVewaQM95yr0I
	 V/FgzfmfW6+wzLCcTkQiN5P5nVBymiQzGsVOMFqrVJsPvhV4eSezYpqzE06jCnJGc
	 IY+hAUldl4TBd5lmB0QeuikEVJfW0UDx2Y4AWF90+PRqaAHIqFynyHaV8ykU78MUC
	 g70emJ/UdHlQbNFlUKo0Ap4jtsgMkmMILdecKqm9ZIRbARtqFuh9NkojLfypBG3ct
	 cGa9a/IpaeCB0Sr+Tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.18]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1tsdVT2iz2-00QT7H; Sun, 23
 Feb 2025 11:30:11 +0100
Message-ID: <31853d6d-a0bd-45b9-beaa-5d67c34ae09c@web.de>
Date: Sun, 23 Feb 2025 11:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3?] sched/topology: replace kzalloc() with kcalloc() in
 sched_init_numa()
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
 linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Ben Segall <bsegall@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20250222-sched-kcalloc-v1-1-4dee15fd8241@ethancedwards.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250222-sched-kcalloc-v1-1-4dee15fd8241@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HDGssSRZxKiT8gDiaJYDr9WtSjjbq3k37tt9irOMvIDgtkfSqhO
 DMUb5lB7Pn5CKR6tI1aUuLEzugj7+s50uJhZoy/0hu3Xx9jYqdsm3TVR2CsipPqsuHfIRx2
 6jV4ZrQfgaNEQITeTbuIq9ZIss1tx42yCT1ge+7EdeVo1bUboPATDJj+WkhD2PTr/b2Xi/a
 8dOGEkCXguXkQzmVXxz1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vxsDjfL+reg=;MknuHBV43lDa80L2CAw30rdXaHw
 akCapvI1poewCtA2hK9DU2M+oTr62mnRa4T7Jl842Z9uKIwzHTkmnAa6NJ24IeFVys/yWtt2+
 wbDYrulvyVlgmLIYXG4DVRWC4lN00P7YzZ8pVymDmDdBVLAqVK3RCTdXucAxsa6zSIZUAdtVm
 wJir+1SPVPQHF9t+hKPUTmaxE/8DMaBjWD4H9A35BT7E+hPw+RpjjIZWfZl3qkgsFWxLWaCZp
 EN4IFmlZfG9rs+a9ohrQDvTNob6UULX0cttmo3Y1HGv5dHZKQ3QqtTepR0opBa9BVdefP0R/n
 7M6gDeAOKFJ4uRn4/H/gsbKBTGzPWfv6nF2fB9qMjIGajg566t9CHYG0kq/4v9rXGmuezoyU4
 bQRX4GrTAQZEhT+4z2sX7Jr4h+AG9BZrWzOtHSP+jpIR6KSKy55HyxJM9/Fl3BvQ/7lVXP17Z
 qwe6wWmwp9dtTlUKAP0HWHDzvQxv10M70nHxoLLbP+e/fqsEQMUGs516otiXqJzPox7NoOy4d
 RBr0+q2b7ArLIz5kDEHOaGo/Hhm1a8tHwpMU23JsWHpw0VIUh0tiNxSbOk4PqJ3IYfgePEwea
 hjDvFcohuSnjJIJ2nZO0XtTE/sGx1Lig1M9fdWpbTNUZ4k5oEwZG0Mtn6k2c50tZkv1+RIS3P
 DhUTaBlEm8R8IN7EbD2XuHL7O0OQoQjQrzfn6+8NgOLq//U+26/3j9oGFTb9OBG2edrHJ95jM
 C0UcsmWowve1zS0LDi5mxd6jJTWYu3GMl2mGguXSN6AL+Va9IYzorbcpzSaMDG2nQZdVIabC1
 rNVCDALyJJFBsx+ldniqYCftl0mARHZDqayf7IkRutKZqce27WQ7/1s4GPGfaVSgOU0o6KXD8
 Yydkki1lvb7OZU0xhpzDzK5vEkZ5h1ElxNVTx3SjGpYt87z0nPY4qa183UKrwi+50s/0i46pP
 oX+bvyHXO2tUazsuOWGQKdziBTOvablY3JTDo26ySyJ+2lnj7drTc++0ssX+WpLJReXDKhL16
 HMlPiW9KWgfOA1s9cM7tDhGZG6cjqNeE/C4eIbKDQWf7ORXOfxUToyR0vNZZK1LfSVozWEYFL
 moe/T568iK7p2rAhfZe9qTzoBFSgEsst472O02VpyNLcQH/KYksYldpUjZDYuA5ZRh+k6QPT7
 EiF+TTUvUv63CfmZWrQe0bARt6oRwLYRSUM7AZSaFNEVnwUhFem2EDctRlnCLPx0SPlPIHolg
 YyBKjxP5M5z83cgChu/0vnZla3xBsSMAjVHGFSEBc07kMMGRXyWE0JS4I4FKYH5lfU1wo5qZ7
 8Tmn5saG9K7/iD/qQZwC+j8Lyi8/hsRNMH0MeTOHqAyIY7pl0RkRkEprr7gvp5d9EFDLN/4Go
 TOvokZLve/U8AwNH0Ah0hf+3asCZJ+01+xowsv8U59pdyf/M/wlu9zz7hjIYxYJ1UhTiDeHcn
 zixYXa9CJQ6seCPtAqhdLlOR5YRQ=

=E2=80=A6
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. =E2=80=A6

Is an imperative wording more desirable for such a change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n94


=E2=80=A6
> ---
>  kernel/sched/topology.c | 4 ++--
=E2=80=A6

How do you think about to improve your version management?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n780


=E2=80=A6
> +++ b/kernel/sched/topology.c
> @@ -1918,7 +1918,7 @@ void sched_init_numa(int offline_node)
>  	 */
>  	sched_domains_numa_levels =3D 0;
>
> -	masks =3D kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
> +	masks =3D kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.14-rc3#n941

Regards,
Markus
