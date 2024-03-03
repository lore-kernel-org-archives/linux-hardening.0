Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C7AD35
	for <linux-hardening@vger.kernel.org>; Sun,  3 Mar 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709457665; cv=none; b=X9HVcJfEiWYKD5tc32aavDHP3N1hH3ovM7yKu2P3hOqNU8b67DMkwUbs1rs+GBRMiMmphYrBzoDRWen3oGk/gSH/j4p49r1AIBe5FuZsCJQYXXJdmBs8T/1y98u9FAYRz9iilXgCJdOdZn9kmbJ/HGP3UwedmMKnwSfGWj+B5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709457665; c=relaxed/simple;
	bh=eQ2zKyXcg6lchPmJDdH4J88CdY7LkmQ+FwqDiZ3fWrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cQ8kdcsvnwWJzKq0Dbfltdpt92p9KNRR0175vODEd3hMeD8sEGDgsTuA0CQfa8iK8Av/5jppPDDUxPF0TTkte/dNcYCcu2cmHTKwZNsXX6N6ZOoUFyTg22LGp2o+t3nhCcr13LrvEnDS0y+6BjPqb320/YeVmXHnh1aCNakoYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3657ae3e87fso48306575ab.2
        for <linux-hardening@vger.kernel.org>; Sun, 03 Mar 2024 01:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709457663; x=1710062463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnnr37vr7kK8/uItRIjje7sAKUW3hU17pprTGtiVvYY=;
        b=fPpWx0eggYIVX1WpcsHIxzhcs2A8vlGjj/S/Wo97hxx0+m5mWGe4AavnaQJt9XpkU5
         iDAI8d+KMB1t7w33B2y26o0jEkm3h01YMwOLDGCQ9J2PnqxmyRNE+069Dqe7bfdl8bzf
         SeA7lJ0hME0nblazLoYwj/VdkkrE6ujlGOCeAVvYTUvmKwgND7WaTG0msu1hy88UTCHH
         JzSGSoVVOdyDqjdp8ybpOCmu1UygujlCMzUi9wQVfLfLPxmmWQaQ6HgTw19glmnAU/eM
         p4QVSX9k/t0KJq8N8rr2oa9WhpVa7B91JKyDrce9M7XyYhB01TcrlR44KyFGXVIrlvz8
         F5wg==
X-Forwarded-Encrypted: i=1; AJvYcCU1TXDVif09XppxKPLxgt/be4vQvvVwUPFn9kl5VFfJYrRVJheEPgjRRazZDrjVxQSGAJFdHt3CyywYohknQcKr4LgGBxNQ5bv15wh9v2P5
X-Gm-Message-State: AOJu0YwqvsJDd5Nw9J4zE0RgOF50pXkazFKEKL5AVyno6W+bqTAKxO+/
	Z8ENHYheZDg8q+H+09kjdKe4KKbKmuRWVnhbV5+xkL90eOK5E6aq/+3HoGM4b1uf0FBlMn1/kuf
	xJ0yEtyH9C65kDFx810hFLUE6D4baIWD8ijOVFznhQrX2/Iiti2Ku3f4=
X-Google-Smtp-Source: AGHT+IExuAl1BYRZUWOqXt/mPBBPeN+jgdmkqUJMT8iH+3nUEGBGafeE5uibvMk2oOpsuDQS+nimT4c6JqP26uCjxEZUZJS11+AF
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:365:5dbd:b956 with SMTP id
 x5-20020a056e021ca500b003655dbdb956mr353124ill.3.1709457663236; Sun, 03 Mar
 2024 01:21:03 -0800 (PST)
Date: Sun, 03 Mar 2024 01:21:03 -0800
In-Reply-To: <0000000000002373f005ff843b58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6b0fa0612be2070@google.com>
Subject: Re: [syzbot] [reiserfs] kernel panic: stack is corrupted in ___slab_alloc
From: syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, cl@linux.com, cl@os.amperecomputing.com, 
	dvyukov@google.com, iamjoonsoo.kim@lge.com, jack@suse.cz, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, penberg@kernel.org, reiserfs-devel@vger.kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1629e3ca180000
start commit:   e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf0693aee9ea61dda749
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10310670a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220c777280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
