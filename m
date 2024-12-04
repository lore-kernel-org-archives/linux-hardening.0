Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF511946BC
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302274; cv=none; b=UpJbL8EQmGv58rPOuLn58FeCUO8TBHPV4YlPHX4cWPo/SlYugy9jYiYHhLBSr6VJLjae8OujeWEg7IqeKbqtqAojg+Z5EmpiFrtO6VqJIMcQ/HpsGN52QQGz0G1zbYsNGn3A/4OnNx6NBI77eOXpCSR+aAAaZ9/nujniRjbEU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302274; c=relaxed/simple;
	bh=VQ7o4p9k6W/J+pqjIQrS4S9TCEX4J7vHq3LJY49VrWY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqjK1ftUUa90La4tscjZL8ILYSY1udSWcSfhorSXZyG10bm392fgaiaGbTljRa2+tplyIxbaVrk2uSwuac4lwUYMhPzs7jI4UuGy0Y8ARN4G6Io4mdJEZITmPCFJADfl07bXR8RdKB9N1XWsq4O8PlEDC0+AmCezHeoNIq/CPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2hGj0i8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2hGj0i8"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd711274dso6102061fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Dec 2024 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733302271; x=1733907071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1ojGPO7ucP1uw4wa8XLS6P/HwVNimrzoqUOWmAuIV8=;
        b=A2hGj0i8vvDTn3SjCU5zgJwrtEm+Ry9Dgma7xMdq1tD/6nmlKINAUQh/f5fNOrrtRL
         fN3Ft4ONchoQq7DxlYoWzRmoXYxooXJbs3/gjX68fBKLnxbl1T7omafl0pEYMFlEeD4r
         fuDZ8s5DsxGxAW/zFRYL6LiNcZxDdkOQkUFkOy35wO1C0FJf3K7hGybq23I1lFfT8xRK
         IBO8shf7oTJNww1KqcgkJNYawc03pVC5+LB91weIA0COYd/WToCnVkQCpAb3zuTHTKoT
         jNS+DEz4ZOC965x+zCf7HEY6Tkz6eN97tBDyEzRMx/89Z0YXse0CEF6BuX8VY03unp+e
         D/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302271; x=1733907071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ojGPO7ucP1uw4wa8XLS6P/HwVNimrzoqUOWmAuIV8=;
        b=HB4VtWIe7mL1bIGJ3S64VXUz+A68Gzw+UaoS04o4DtvSl4szXnig8Sz9Omy1IT4hdl
         7SuGzuY1NPuAHZFZovKaD058do1SqT3Vz2RfGR/98ldepUPhFNpdCz3SmW66MEOTO3ga
         m88Hb/vYdrpSTZt5KAy8iCjouWfKMxXMh61zyxx3gvu/noCJT+hkRUvxIvxZfEk/Nh9T
         V2PTVbWj/b+iuFRx4I6e5Y8bIjYHF3Us475rdt7ga2agXzw40TBffr4n6YuA+xo70B0Q
         yXtjVtIro69H9om+Is97knQjHzPhKMepRgGTFnllSBesU5hZHfDj9ub8/DksXFIKFrAI
         pm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXANMcwhSkF0r2IYgAS+S7BkKmwH6/Hp8x+BlxZylzAckGOyNLNGmS2VHtfvppBAcnEV2KPb7A9UacNgkjFVDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QkvCgQwYzLBzzj9WGvCuLmyXCiJTQw/jwGv0CvqZjKZIm6hL
	3Pfka/Lb1LQPtEdxedOQkptAKBhtjD0JtjupL34OQhHmPk7ZbV+M
X-Gm-Gg: ASbGncvA9T4IoRhAeVQEVUXVRvWGoS/mE4egxgnT3uiY+/5YLZYdwOH/9BhEggzpneK
	9mPsY6GzNml1jHwcDIUD3dfXdQ5HWE7fUphHy8IgnDESCAX9EmkDbOyieEPX9GKlvs3Hn8OKEuf
	HwYXBENiovljT6DShF9ct7ic82GzynDwBuCmk73TotZXCz3LAkGjLXj4zTI0/Nv5kpyLNyG2Ei/
	UsPTxtr6/IN/F742ImUfd65Cf7q8c6F4od8Dti8eaMysy7r6oMtAaS5E6LntlhhEOc0d78IP2E=
X-Google-Smtp-Source: AGHT+IH8G9sleFDDzru+0ejOl4GXLbUU/PZbUXKkSy8oGiNrjllINOpOz/N8n1wA2CS0hr57ej/nKw==
X-Received: by 2002:a05:651c:160c:b0:2ff:c080:e4a with SMTP id 38308e7fff4ca-3000a2afa3amr16922801fa.18.1733302270720;
        Wed, 04 Dec 2024 00:51:10 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbef4aasm18466261fa.34.2024.12.04.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:51:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 4 Dec 2024 09:51:07 +0100
To: Matthew Wilcox <willy@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z1AX-xhOZEZqH1Jw@pc636>
References: <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
 <Z09icnP7QuaLg4Qv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z09icnP7QuaLg4Qv@casper.infradead.org>

> On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
> 
> I think there are a few other things we can try here.
> 
> First, if the copy is small (and I still don't have an answer to that
> ...), we can skip the vmalloc lookup if the copy doesn't cross a page
> boundary.
>
I noticed that, a path which is in question, does not supply a starting
address of mapping area, instead it passes something within.

> 
> Second, we could try storing this in a maple tree rather than an rbtree.
> That gives us RCU protected lookups rather than under a spinlock.
> 
I think, when i have more free cycles, i will check it from performance
point of view. Because i do not know how much a maple tree is efficient
when it comes to lookups, insert and removing.

As an RCU safe data structure, yes, a searching is improved in a way there
is no need in taking spinlock. As a noted earlier i do not know if a maple 
tree allows to find a data when instead of key, it is associated with, we
pass something that is withing a searchable area: [va_start:va_end].

--
Uladzislau Rezki
