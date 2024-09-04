Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA513B295
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435480; cv=none; b=VE3Kg5tGbCRmU7qYIfwVtiLucVtItln5dzQRwSTNF+gpRi7tPs7Qa8WDVlbf19VbIpRrAqoxq/C6bN35BHdCNSaHMQ+Ix7W8x37SnwEG5v/c1gEzp//6OHttUAPY/zoJtKRhTBIvnZH5Zed8LpvUAUXGM0lvqbhZfBQQkFdkll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435480; c=relaxed/simple;
	bh=ndA3ctT8DVweIfk2x9lQZmbqQq5PgHHNNbNaEkmSkAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af4NeWXu+z0pKc3DsCvs9cJ9diDRLMm9/kYDc8cDbVaoj0PhoVdH6fdcl6/FNLDP+G6xjX45G3WiYN37CUJMNcZ6SOlFGDVzH0mhDK4gvEN4eS3O+DmPcJ/EZ3/yrbYxrcYJDgIdHLT1p4Jk48MUNSmnZxVo5UDzzThdcCzbl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsBqJcp+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsBqJcp+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a869332c2c2so71329666b.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Sep 2024 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725435477; x=1726040277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndA3ctT8DVweIfk2x9lQZmbqQq5PgHHNNbNaEkmSkAY=;
        b=JsBqJcp+b6bwxfwmJlg3JKwhwpC3pULYiik/DtC9EIjkY6ErhJRFHsLF0t7IIHC/vO
         AluM5joR+nEfRNcBygGL5aZtBg9+C9Wvuey0F17wSMwRumJZl0Wd5DUhZMQYYzfOI97F
         Wo7J4FglJ2wGN5eYYafz1L0Rn/80YYDMbVURpdzef0a5kjnA2r3lOHceQrqfLku+NlvV
         dbX91iTapIKp3D0aP+lj1VyGrCzggytTehKR0wZkss81xDrwTkehHcLZwYljLnZ9ymmT
         DCBBVnbKIxK1ZRlDW+24fS/04eJU4qV8LwPf2SyLbuRwRKXDkhU0HivvKj4qz+LON9fD
         a5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435477; x=1726040277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndA3ctT8DVweIfk2x9lQZmbqQq5PgHHNNbNaEkmSkAY=;
        b=pukyqBvRglcA4y+7EQ2BD/+2NBc1hGiDPUnhHwPCAsORd0IvbuSw1vEa656x+NgPjq
         2rDq5n+zdLo7a2Dt8l50qjEXUfCqpCfbk+sjJdD6z86UkEMknL5O79ZoJlfvBHR58xhj
         a9MBrtT4bHq+E9MvLDgsfMnldQHsv+xZbbLNuwEhJPcRTu+U8g1RflBdbyEU0EBfJcQ0
         zF/8rMCjONoI/+ApU/KkT1j11QJuVGN/WYCyYu5wz13GWcFYBVzsRnyvuccvKinqKNOh
         rEK0ey4BV0UyLsISi2pFrMTgp8xZ4Zmqq01ppWwvKpP4Hi14Vh/xKZ2aFmOYiOYbLNlB
         nASg==
X-Forwarded-Encrypted: i=1; AJvYcCWRppiXQG/K87UyrYCDYbZoUxivUGGUo6AT/srXVVylk2HPceflLFvujLpRTUqVxWXhAr8mO3vFh+IiT/giReA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyocolAn0sHl0xf0mIpoz86CwNDH2FNonTdi3uQxia77dDcVFC
	jZvI6lahj3Vr7OqJ7cf7kUoaMQALpOwTDe8cUY8xDWZOPFqhoTeU1A6I7y6lxUAwu/lupROrs6D
	Mt/caanGA0jnzwSAE9sGC7+02n0g=
X-Google-Smtp-Source: AGHT+IFpgjsUa0nKhUStWwvqJvGf3xxA0iT5YlfzYRxh61G75r/FbStsWZj78l+nUJew0Z93uIhEIrJkTfo52U0ELSo=
X-Received: by 2002:a17:907:2d8e:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a8a430adb51mr139356366b.15.1725435477092; Wed, 04 Sep 2024
 00:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829112455.232263-1-lihongbo22@huawei.com> <1c8dbb13-e7c1-4031-8c85-a5a676eb8fd4@huawei.com>
In-Reply-To: <1c8dbb13-e7c1-4031-8c85-a5a676eb8fd4@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 10:37:20 +0300
Message-ID: <CAHp75VcEhn8gv_aGGsTF_FkhqStqSWcR_rUr+BwtQ5305g=cnA@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] coccinelle: Add rules to find
 str_true_false/str_false_true replacements
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, Julia.Lawall@inria.fr, 
	nicolas.palix@imag.fr, linux-hardening@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:36=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> wr=
ote:
> On 2024/8/29 19:24, Hongbo Li wrote:

...

> I found that there are still a few function rules that are not complete,
> such as str_on_off, str_enable_disable, str_yes_no. How about adding
> these rules as well?

Why not?

--=20
With Best Regards,
Andy Shevchenko
