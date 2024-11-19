Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012E1D5CCD;
	Tue, 19 Nov 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054970; cv=none; b=KeFNgGy6lkdryytLkdSdNQ0TL3mW7BbNHVpqMC+xmgsvC3i/mkI9F/Egt7krCJeRactNBwbW2lQfuIF+2honddLm1I05rVV8jtazaMt0vSQAx/WnDrcsd9SxCyjd66d44YjELdHT/xG0ZJOMnKU8DJ7bWH2jJSxNjnVot+eOatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054970; c=relaxed/simple;
	bh=frmBqz2+kAXYjWld77XYtO0r7a4hA1sE5/CBNko3mGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPOADoHYvc2JJZX0iQWcYr92w9U1ps4Y3NyxxH3eJ5q9mzmGkIexSzaVhXxFLlRvkhcvbgrWRR7w5xpaUj6/K/w26UUPHhb15Vg4wL9+db2KVEkYBIiRix07DWxUjpIrXLhJjm/xebQFb6gcOmlZvjnRzLoj4HQlX+NGCb4tqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhgnsdIF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhgnsdIF"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb587d0436so35237501fa.2;
        Tue, 19 Nov 2024 14:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732054966; x=1732659766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VCA447h72acIoFwOSqYQV/WfKXOkE6l+r6q6ohnojI=;
        b=XhgnsdIFWquQ5be9O2GFtLy8znRhzSMqzc+HYMqp1Wouy3vlmTxE1esnp9B1Ru6GAe
         8se0QpGi6wQcLKnxsBKHQqY4thrhhoNNa9AmjI/gvhqw7RqKh/kfHoMtnDKxm5ZWhcrj
         TPFIG14e3Zev/ACnrX6TTALXsTcfJnYpK390C+LwxFQDW+rtROEswCyuXH5Q7QkhrVSR
         IDbhmqz/1DS6o5A6ldYcZyyGWSq6UZAGOYq+EBOB8NaKNNn5DLAKLLZJvarxTD4mP2qV
         bt05eYI2mpwGtyiHXuz8qkvv6eoKjQN+hn20thqt26IIDXfuI6fOhq1XiVEneT/a63P+
         b10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054966; x=1732659766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VCA447h72acIoFwOSqYQV/WfKXOkE6l+r6q6ohnojI=;
        b=FlSdQUlj6xCqbUuQfO8gVLuhLCLMV4pMeCosriWsPSvI0P32g0nifGepTa9dIbuugR
         tL7wSain3JhUBti9T8j68Ur6F5EgHsz7sT0YnnQyh+kxtW4NHwTtt9hfxQRLkb7lhsuo
         ivSTKqOF1PU4P6XG14qPIl5+lk2xHuXYno9EC+Kggshbj7r18CAH961MYBw4/zWTLAPR
         77inlnsVE7BYASmojR8aiQPBQGfKJvM1By0XgWoq/JPXTu7LGNnEotsDq801kvtNkJRs
         2iFhgXsS3NZgIkynHfNPLQ4ZClQfC7ilroIpcxYbEX5PHNCn0/AQjakXEjRYegUwctaj
         O8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVsdyu70A2tMj4fWN88tq7dP42IB/tW0thl/3W44vkVyY57a2soG/kc9E5gfoE+O+Cc2cHRxpm1b5jnFiWWsu8=@vger.kernel.org, AJvYcCXUBeyAfL/CaMCW1sCNefHibnJejj176ZXIIFxiqpaOFcwsHUN8Eg1WfTA9ub1emaAX1c1AnCNtURZma7dc@vger.kernel.org
X-Gm-Message-State: AOJu0YwQa89uJUcPjb5NPz/yO+YKBAuK0ZgcZmrYmwn5qu/x8cmUemTL
	OcrAxyZZR4ORwSPSBHED7tLdVi/z0YjQef66ltjk2O/WXYOsBt/vhhQQqdq6r0DxyRi4+/DvZo/
	Gy8i3LF9nyXzqO21t8c6bmML5Hl8=
X-Google-Smtp-Source: AGHT+IEAE3vAwgH/geRhf2LTai5j2PQXBuUSll2Pv5/4wm3AM/D7Ler3jx2A2ezdGYR9DXAIhleyoCnSeNW/pIevwWo=
X-Received: by 2002:a05:6512:b8e:b0:536:55a8:6f78 with SMTP id
 2adb3069b0e04-53dc1333a78mr126709e87.17.1732054966392; Tue, 19 Nov 2024
 14:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com> <2024111914-overuse-cider-7734@gregkh>
In-Reply-To: <2024111914-overuse-cider-7734@gregkh>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Tue, 19 Nov 2024 15:22:32 -0700
Message-ID: <CAOZ5it34RkuFwd36ATDT=0fQc4+FjOK03N0zdXxgyNZ2qRwHBA@mail.gmail.com>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> I know I said it privately, but I'll say it here in public, very cool
> finding, this is nice work!

Thanks! I appreciate your earlier feedback as well.

> You had mentioned that the size:68 numbers were going to be re-run, has
> that happened and this really is that much of a boost to that size?  Or
> is this the original numbers?

I re-ran the test, and the numbers are consistent across multiple
runs. I=E2=80=99m also surprised by how significant the improvement is for =
the
68-byte block size.

Thanks,

Brian Johannesmeyer
