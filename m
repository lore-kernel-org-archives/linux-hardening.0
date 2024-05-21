Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DD1494D8
	for <linux-hardening@vger.kernel.org>; Tue, 21 May 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324965; cv=none; b=ejOHYhbJtU/qxQlEZGYkp3W3SCNRqOoMxz78tJ/OhOMC1jZMmMfUvzriaWgyhWEDFZ9Q09BSJGWqx+aQNdqcwLW3V4y4QAknqDU4MrB5Qy6DMz+PFPRXBzJ4KVTkppMpjSo1Du/RIKloe1LqyvlKPEPRdcL1C6ZTKxSEx8yNHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324965; c=relaxed/simple;
	bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BFnz7NfMOKzUgc6ty+ir2jsi1K6+cKQ+2yTImp+ikAhBubW1vJgrhggwYl1BLfthqKmJkBAzeZjwg3HeD0o5/J5pDYC0p3MJ26+mSerkpQ1YpPOEKmQNB9XrpqBE6Y3YCqDCbZlVhWZWFVxVVE2vK6+W/kehkuLOI8ggGIIEVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tiws/Mon; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tiws/Mon"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24544cfbc69so1975937fac.3
        for <linux-hardening@vger.kernel.org>; Tue, 21 May 2024 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716324963; x=1716929763; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
        b=Tiws/MonIon6cnbOMs+FdnaKxtRNYkO7DdF8WvLW6zJDCgjy/w3ikKcVuA4R1pf6yd
         IaeAurCMkojwjWJOV05TodcuN75c9Ff5EsWi69WZzuXPIXTlargkQdcJtqzGgIbslOQr
         8O8B+wn/3Hg+Zba5h63pQYdM/NiYo1t1n9E/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324963; x=1716929763;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJiaqEAU9sSWZ1B+ERJ2EzFdFTRMHtGeptWAmPSNdbc=;
        b=hoSrka1rLub6psEujSDjUmR5K7uM3x3+QsUC8q63dqLEPFnw6QB+i1Q4+vyyvn1fZQ
         Xj98lYiICf1FMa4GugBzzz8oaommQUEh4koOEzmpF0RuiTyLkA86eo/LpFbhCEt0no1f
         84EgsAEk2knGmIb8buqTFQtJarZoiQyt6q4MzH3pnEvK4ydCToddF3WDlbDW2wjCoXAU
         w/qBbTE1/74ip339ylvJwucQrYu68sUAAaqoe+4cCss5Z3hDX8xdDp7E+KrOpm8NhSpl
         n4G/b8rDzcNvrT06pvn0fKwnj3SL0WOgbKar8N73JSjRElSZCyoBDr/DDA4vMEg/Fsrh
         YNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHIZvhN0w426RpGfLU+wkKGPT/zskNEeZz/d3Z0Lwdz5pUmOVxzVGBbe5a9vqhmSJFUYOwtW4hE64fA5YJAbk2cZgOl4YEKus2RMRly3S1
X-Gm-Message-State: AOJu0YwkP5kMb1FsHj4v54Qm9x8IBW4aubBJQoSqex2LxAZbm2MIik7w
	qFVs9wAvZBe+Sy6JgxQ/Y6bqwpmbTFDDVCje6vlMbpsBCvQxR5rnE/grDwFWSgsHUEH0OIoHPKA
	huFDz1K83yHSX/HS3hQ2OKq00UYGb1zDitH+F
X-Google-Smtp-Source: AGHT+IFVKWZED7guJzc+MzWuGHfaHJUwnJp1kEX7pxfEdSQdnNlThEftDlYt/MqxHChTBxk0kLBrMDZyswbZxiDXzxE=
X-Received: by 2002:a05:6870:b00e:b0:239:8687:d01 with SMTP id
 586e51a60fabf-24c68aebafemr258687fac.6.1716324963212; Tue, 21 May 2024
 13:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <d46qb2rkfsagw22u6ishgagsvsmqsu5nrmf5up5mhi6xrwolyt@6ir6g2v63of7>
 <CABi2SkXBpL8qdSMTwe5njWasqidsWDkhme6xw2_38JARrhPRwA@mail.gmail.com>
 <3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbayw5ntgk5a2rx@jkccjg5mbqqh>
 <CABi2SkVLqE7WD2MTYpksxA3+BfLLzjibHeJy9saYFvM-GRFy-w@mail.gmail.com> <khduyf47rifr5bmswkbju6l5itldhqaksjasvnkfhg4ig3ngdc@a4c2csfsdeqz>
In-Reply-To: <khduyf47rifr5bmswkbju6l5itldhqaksjasvnkfhg4ig3ngdc@a4c2csfsdeqz>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 21 May 2024 13:55:51 -0700
Message-ID: <CABi2SkU+6tSO6UASTW+7WNX4ySot5FPz5shnjE8b1OeXyJu-=w@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
>
> TL;DR for Andrew (and to save his page down key):
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
Many thanks!

-Jeff
