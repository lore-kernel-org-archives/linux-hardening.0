Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792687598;
	b=euK1zoDO9ZWbNlaH51S5qfRtT2hQ+3edvH5/uyqp9cmAg93lLrautOo0/+Ju0OG7W/27
	 Wk4xrktd9xt3DGWemPx9DuBT7KWoIBYbT646NN/okKQlvxg8GbSSGT+tSwnUgnt1reLgT
	 toFbeJFi47dZ/k9eR3JsNS/YFjiwe5Gd1NuIYiJXDqISaUzqcW2mXcgrLeMr9uxylJTED
	 nH1E1gBOojHaFuduCJyEi9AUc3b1IDwvNedc51WtpY2mFumgB+98AIlvl1uUndfjtE1Ra
	 /2g6E1X7PzHAqXnpewdVtKvTLrgKV2DSx/Cg86N8Gt+TYHG0c38pTQuhWCD5T9NbBHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
	b=VW8kZ5X6wj8TwX816A7R3IH7YWyNgkedSWFG3OMuzZo4PgXbF7koljo+pDX3FSKGTRcC
	 228rkOvLk/EXSecRodrVBw+L+FZryFBuyM1tBkG7B6AZwYWX/jDmLz8UiQBo2H07yTr+j
	 ocechr7qm5dpSbmG9i4NJ2/cDycdAS+DDSd2gR6zeatNwv2rTyyG8ZdI6BiTWCBco8MJp
	 +KeLvHoyMryqLAFuHLLXodBMQES4fwMkoEY6sIGEquN7jyyQFW0qJItXXbJCXPdDVLGGm
	 U+g0pVSxQEKjUSijZ6rbf0GPJx564De78PsTa5IKxuz4XKAo4UPZnxrZQzziZIN1ykQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GwsFZfAG;
	arc=fail smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F1606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 16:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GwsFZfAG
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so85455ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 09:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687597; cv=none;
        d=google.com; s=arc-20260327;
        b=O6FA65I0wPOZ/w4U4C7CK+qqkEOYo96IOm2vj8YI/2MZBZ8KShvOz6+jeY47YJWiD5
         n86TOsQfXbqRoVraaSo9hR2Guu0VDMqMhWFeKQ+NchuC4vto4iI37D2N8qX4ogMUgWl3
         /9Pidfu2lnM2TmeH5zhR5V8lRP74NGUJWo7CvsAZCe5EDfh95EyqKpXH6xUq4P5LbsSs
         O3t072DTwNNfVy7bImZKQPZmrPdHh0iS0OBU4I3HyRM0ul5ybRrkxRcoS3g6S1h5ufDA
         +YSj98Qsu0yVXSjecy1rx1D1cFSQ8MNI3panUJ7PoMbhJBrB6tVg3HYXvvTiEBQ+muXw
         t7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        fh=TRxOSuje45pbOlYyEV8EqggexPyE/WQX3olk6Xj+Cfc=;
        b=NLrtD1XCWRpX8qadT2EaL6lqhupMrry4tWgLjU9GAiA7+G6rSmwMKqKEiv/+o490lK
         dS/oi1usEyrj/+rmaLXeQMvjXcXJgcW7tLanjMvn1v1M9F+OLl//QqWA62OUYjV+CUol
         I/Ud7UPanX+XPwebWW4kI5rgZhjPAez2AyI65zNLPSDAJ81/sYjKTCnZ/6xxSLExwtGu
         yWLhCBe9Hs0IjfHTgqI6C5VZRnW0LgemtxtQvOVzXc2qwFPHZq+AjsEEN+x0+TyIEUKV
         v0EVu0pLQ/liv6/vxXPGft7dQSzK4qeHzsNTujvpgLHtCM2lQqkV9mB3jopq6owPNNfC
         7RGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792687597; x=1793292397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        b=GwsFZfAGN5WK9cknlncIZ+dExC3F9P6aYB8Y7HxgAhobV6QAQgPWZoSO354JKjEpvF
         FPWjKKUDWFpR/YFwVogODJfj5PyEUOMF2ed4wZsK6z0h0/jjE0OHp2Dne6/F0bjLNt4V
         X3UpSMUASG0FzhAq8jRMWIVOcqp0k6ZLrJ2KiPPyu1RNTtI+lXFv8RoRTXowpr3bE+Qs
         T2nwQWAFaJ/pzE9nSsvssHt7ZOMRI2yjJu1Foq78zmJdr0k4DBeOfbHt5rIHOZYLxSbc
         T22YUmHcNVpH9EqeeA3KGKLqdKdYuXVhf2cjKdTVXTRsMUbawAqtlBw5WxvgxN+WH6T0
         7aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687597; x=1793292397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        b=uepPPQ6A9bnZaEBAPY/hD2n0sTdU7EXxkLdt3vNpxveTbD4lE49Aj3ZHj2KpLckPc0
         8eoyiD1wFtmKRTmmm6VT2O/WXTHT5LQ5jNVCPrlKcsJ4yf8L8YqdHA8taptkkvc47pu/
         nxRDcsF1XGaqQbqqv4hAo5xPiISL+Ew42VCcfMw7uzRjc3Z3cf87G7kk7GuJEacrRfZI
         4CWG3eGgppExyfi+C8tO5F7RjIrpehnLJXISqQM4DEnD1Cho9uRfcF/pKM/z7IDPiPry
         MjR397rIZqySSbjl2IpA+61F+HUMuORROHfdpYrjlL1P5SPdDa+Wtq2P2ja9MytiNsdX
         vA5g==
X-Forwarded-Encrypted: i=1; AKwUvByW27JfeLfaaHv7ZxPesECqsGd6Ex70oll3G375QKENOOR0dEo7dOsvbuU7jjLWMvrsAnaSyHCFoHVSeUPCAf0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn7r9WXkE9FFGOc6LwkX5gR3YJcs9gHEPuoQdjX5ztLj3lheNn
	uuP+zZPJq7bC9kA1+QvS/+VO1l5qHzPwjqjiPMp2AacetlyjhKopQ8FTIAIapuAvlqviiuZgCkY
	BdoTJRDnc8OvIy6Tb8STKiKG9dL0Uorj6+6nBWc7u
X-Gm-Gg: AYBFou2U28cC0tDnIVS6im2eBVQMypiiohn6Uh2sA2cwlepRA3CljxU04vN2sAiDJYX
	71yJc2Md43435+EhJSWhEw430mzysHOq2XfenAkCZVR9JJsYvE0nDAUhYLM5QxGeaXD2NCPSS/3
	238uGLSEO8ZbXGCsjR1Uh8pVo+fAtXUosh5oq5GQqLDIclojwLSLPFLqvO9eiDKJk9XVBbYeEPK
	qowcs+WVe7+NeQxyGyxDFX3E3wpyENL4lxttW98Z/C7+9d4uui5kglD0KOnUcbMllSwqsmH6fWW
	2sSs1YsNzzNThgbE6FgYsSZh2DEIuYCCdxnhMIUMX19gCw8fhBxP4eMN2ZTdieMLiECc1Z8p6TG
	dAXB1wb8P0ARx4GBiJCyTLkoXL3QWfJ32zCKGoHl0FvawliI1Rd4maRlgpKjynwtDZAjB0g6QO1
	8ic8cjLevGBaGp30DjL9tpeA==
X-Received: by 2002:a17:902:db11:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2ea63088254mr5085175ad.2.1792687596491; Thu, 22 Oct 2026
 09:46:36 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021162538.1852602-1-mic@digikod.net>
In-Reply-To: <20261021162538.1852602-1-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 18:45:59 +0200
X-Gm-Features: AclHuK9zuGI6ax3vqvDDohM9t-hsk36f5joo8NmHv8Bwy_LXI-q37xMxgIQtv9M
Message-ID: <CAG48ez3Rptvjvt=t_YEcBHHwYGD4zmPtc6tk+gPLtorZY7WEFg@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock update for v7.4-rc1
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Haofeng Li <lihaofeng@kylinos.cn>, Paul Moore <paul@paul-moore.com>, Tingmao Wang <m@maowtm.org>, 
	Wang Yan <wangyan01@kylinos.cn>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> Jann Horn (1):
>       cred: clarify that task_struct::cred is only for the current task

FYI, that already is in mainline as
https://git.kernel.org/linus/b030ffaedc1d638f232f6992406cdcdcc82d5602,
it went through the LSM tree.
