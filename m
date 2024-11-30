Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065113BAEE
	for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002468; cv=none; b=ngfVMNRrJy98whV3WdMIlKwPFYcaTrz21+c+IlDhb1LUwwwoPLN8s6xImqhS5kAHL13lclH5UqCL0cqXKl+oK14xeX5D85HtHmKepT1otZX8JUF9AwGFkE1SP/uuOaonFdtAYQLwwtmvERhiVA2r15zof2Bd7os8ZVVBGhznqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002468; c=relaxed/simple;
	bh=9dW6bWsFGFk529Smtr9Gpb2nVhhhhNJjaw2Mew5NbpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iuxvq0BpabpgdiWLnQg/D4uBq9PlzS6SuxCvOkFJZoIIfWm0gMEzWREO999etoc4WD+Cf2Tia0QLGNcx7b0WfVDDPbXGKPjS26PHHah00S5wSK9SbxS++1PHiS30df2AXickwKBrClDdVJ+Is/pNHdLGw7jrXpY2g0f0MNk7Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WDObW6hd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WDObW6hd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5500f7a75so470320866b.0
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002464; x=1733607264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=WDObW6hdpNf1q0ebPK0IhcbXSUpRmWYqC0pDKz+XSmh0xp1Si3VsQIwCDszrOYlitn
         qUVIVf+oAO0Es9O7LKTdKn3nEz4M5PKZ7NV6CbFai9u+7cDXYkOQkSB/UGxVPITK0XyA
         hddqcIAWJ9+/5ChDiw8Rv3Up1Io5TGtdbV7uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002464; x=1733607264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=cuQtNsMytNfXwapne2kbAyyfm5fD/1d7eEGBB/lGAigBV7NKQ463/OpsxZpF8HKmMk
         mPJzD65bjJ3QzNQr7atwG1vkYbX9u/yIi86GAspAVQNaGdTFecT+/A3op2IEkwAMWfwL
         zJhBKMjGJOuLKaq8sVKKdimVvDuv5iuSmq1X+hc8emdcQqroomJOTaTTacx0vjMB0XqM
         HfY3495gcw3kn9D3htwYRgLzCZu822sl8FdItawshN95L9sjmPqnGyjEkNzPiJVGoIoS
         ihNSK01tDaBlnO8M1Di7sRKSSBaJ4sAC9wanYadissPEVGzZWuhdKgvtJzTo4ysc7jal
         Eu9g==
X-Forwarded-Encrypted: i=1; AJvYcCWeoW0Shnl2IxWPzleLsYbo5lBZMjz+W2lnN0L9lQiUyXwGtvK0avEV/pOAkyRgxZjFfTDF5d1zSFnsFBBSfrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0CHhPvfSsQMYxRhuI+4f7Ehbn9kmcwJFjR9rTjnP3J7NVNMKa
	Z25fCHdaE78JfqLgXjiEBZRO2jdMharEPYyp2bdWWFI79uoKtjOHx4CQj+2ozysoqZNg2/KCxO4
	LQ+uHnQ==
X-Gm-Gg: ASbGncvMfRnvvDNWcg3zr3LeSQH2EXaXFalYnlFPm4ca8DILm4HH1iAA79Kg6GqkYBy
	gP1yKGFRJrmew8m7oMB8R4ujzDDKp5RreD4il7iI7c7mXbXJ5SNNxgb8UaYcZS3iGUX5RKC6rJ+
	4NvQNd+3/wOzGykHEcyp6rTdOZM/TG1tAWrv6qdv2ruAxuE1Pn/bkgd+TkvzKc8aFJyfxuej2hN
	grUwJM5FZVLPQbJWXavO8JAOBb8sfRbA7sK0gEhsqHX56/xz2WqEdJGDTbliOA8s563qwmg7Pp6
	gmrI90KBdlnyBoYOZD2iIE9k
X-Google-Smtp-Source: AGHT+IGZDGfJ1vpISzciB+NUdizCp8SYzX8kHe2T0qKaqraegS7kcB0qbx+FZw0+4KuSU0TNjGlTVw==
X-Received: by 2002:a17:906:30cb:b0:aa5:e00:52ba with SMTP id a640c23a62f3a-aa580ef0dcemr1278949166b.11.1733002464412;
        Sat, 30 Nov 2024 13:34:24 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c11fcsm319523966b.39.2024.11.30.13.34.23
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:34:24 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a68480164so393095066b.3
        for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 13:34:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9zrXPpE1n5AK0b6UtsSVMsydVfP1PQz3xDfbZY17VGPuqWSvnYLRRz/W63KjGzuqUQYehDavw1XxRleOJgpk=@vger.kernel.org
X-Received: by 2002:a17:907:ca20:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa58108aa80mr1263837466b.54.1733002462844; Sat, 30 Nov 2024
 13:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
In-Reply-To: <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:34:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 12:28, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> > +             /* The dentry name won't change while we hold the rcu read lock. */
> > +             __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> > +                             true);
>
> This does not sound legit whatsoever as it would indicate all renames
> wait for rcu grace periods to end, which would be prettye weird.

Yes, the "won't change" should be "won't go away from under us".

          Linus
