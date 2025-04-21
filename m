Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA38BEA
	for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745210022; cv=none; b=ZPgzhHKU4pg1+UYH2nmGpD/w5QUspWu+SRwNcS+YLmtey9zBQvZ9OLs4bZMYM3hCMYfbT8aJn4y3/gYxc6LXVaVT3/BBjH+4J+lKetCEOi4LbF2+mLYQRDHcjdSZ2z6o+dQL5iacyL26E5WxM8UsypSIUyHuSp0un4sVZvzAqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745210022; c=relaxed/simple;
	bh=JN8iby6an3mfDwdowPn91zamLY1xRGg6bBMjYkZ0DIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTqKU9ze4zlMzaguTdZqUm/kL2KqrpTUuSY1m/qBKgJhm2uknT/TJGpuySG/py8j+k5g3Xs2RBBhvXwu+OgYGrD8T0DLr+fHXYi2dyBwFxCTxVR0NExP4kwopUkqkYMPwZrsF1r6S2LBjnjiQTLm1u9dO7VuMlZd7PlxU9n51u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G9sfdlDe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G9sfdlDe"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so4393571a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 20 Apr 2025 21:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745210017; x=1745814817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVqDWiNRjRqlUA4pP3gMK9BF373U1wIAPXz+PfM0geY=;
        b=G9sfdlDe/W+ZBdTwrY4C7XMLivfz8ElF0r+SuUE1BC5QUUEy1xqhRJIqyfgMRR5JDt
         0EWczxNPx5u7SHuw2/rDNbY4daOog2pIOZ4HRyZEIUqHwztS9KfdClj1m7T1BtCBA+NH
         CFAQa7/P8WDz63Vss9/L39L5aZIQls7u3J6dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745210017; x=1745814817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVqDWiNRjRqlUA4pP3gMK9BF373U1wIAPXz+PfM0geY=;
        b=wleA3ywvn2aJX0SrgcVwJmqVVLhAA+VeMmdTcc2+jUvOzMCO/FoQTfDpZ0/373PXoC
         dflAJFCzeBXIXeoQP0JFNmBPQjgyhD0X50ADlZ69ApcJbBNcBIWXA4wxABMylpDzay9C
         MLjWtoVXi15wQg1uMVvWn0rbQhe9KIlkRGW1LZ4Ueb6T4reil+/MKp5GBxrpZYBt7bkC
         VKo9aoGW1TMfu0vo/OyA9pAJmcVRKOc4Q4D4a7zMaDfEQwo2SgWg6duhBhpjD5PDHhXO
         mBNRZJaXtCgXJtHBpfYUJJIOLf7ZrVn+mkGBy+wF5caiTUZZ/mKKmK1ocHN8LAEcPRAs
         xV3g==
X-Forwarded-Encrypted: i=1; AJvYcCVz9Y6xtOMmQ/PxpNcLJeOZewh5vz8vaaeQwEX0jf5cUmpvmoj/8cUPBbH9EPi7hQUk0UFwcBIhhOO51maWzXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTufl7rKxO9L3QRYKCCc/GCKkbHm8jR4SCgOqIyKov8ESNKBe
	NPK7YKpV4+huJMteCpb7UrZH/mBXI/rK56SYU4qfdwH6mMcbm421nvRr3gDd4uIAtbKMuF21E6y
	Fck0=
X-Gm-Gg: ASbGncs32GNguB14jerxDw38SKwmic0x+IQh6xnEzEXxDa6362paX7qjSZbqyORC/4o
	ZpAZKy6InnL+rc4xdD/ASHZ/YsgHuyPDkO0v2kLcojV/IAS7t6yYgrM5Bi1CmbshMO0ss6wn4Tu
	PQMSxf5bAluRjTFUgdFXIPopEAKzTqGhR6NOPG0vqH3aHOguerTCz+GA5/CxVoqXxb0OwWTIe/n
	6qfzszoOWnjpN+eAwHVLAjEhTyyk0auFGP44DZh1DLDUEnPPTY7JFRxZWqsbleSJnP5wUmpDGq8
	pvdumak+wi9/V4wOSuDCTUgp8OxIyHAAryK1ihcSjZox5TnX3AEUp7QnF7jVDkgCZaN9xV2sxkx
	lxylB/osi4YeJviQ=
X-Google-Smtp-Source: AGHT+IGsaXqPWiIhNW0bp62EjQbOIaw/C1z2fvwuAKxGNpiDtqJOKWIKA5AtauM4LDrH72i2vumI2g==
X-Received: by 2002:a17:906:ef0e:b0:ac8:1798:c2e7 with SMTP id a640c23a62f3a-acb74d8313amr1079200166b.41.1745210017611;
        Sun, 20 Apr 2025 21:33:37 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4235asm457721366b.39.2025.04.20.21.33.36
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 21:33:36 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25520a289so476077766b.3
        for <linux-hardening@vger.kernel.org>; Sun, 20 Apr 2025 21:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTR7n+i8UZLAOAGzQFm/4IUzc64gu8ji+FQ5V8TnT1aahjGiMz9Wt8oRcst+Kal+e3BS57ryjWJ8cRiIz2U4Q=@vger.kernel.org
X-Received: by 2002:a17:907:1c14:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-acb74b508b5mr953823166b.28.1745210016471; Sun, 20 Apr 2025
 21:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net> <202504201840.3C1F04B09@keescook>
In-Reply-To: <202504201840.3C1F04B09@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Apr 2025 21:33:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
X-Gm-Features: ATxdqUGGqXh-vFivnudAlmvqx6H6i8OFi9l4FYYx5jTgGwSOGb4QhTZQHzEtAbE
Message-ID: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles around
To: Kees Cook <kees@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Apr 2025 at 18:52, Kees Cook <kees@kernel.org> wrote:
>
> Can you please revert this mess and use what has already been planned
> for this warning? It is, once again, really frustrating when you update
> to unreleased compiler versions. :(

Ehh. Kees, that's the compiler in F42.

Really. It's not some "unreleased compiler version".

It's the main compiler in one of the biggest Linux distributions, out now.

Why do you think I made the change? Because the kernel DID NOT BUILD
without those changes.

So no. This was not some kind of "solved problem". Quite the reverse.

         Linus
