Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A43158D96
	for <linux-hardening@vger.kernel.org>; Wed,  5 Feb 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768806; cv=none; b=t8u/9DmlG+oRn0B4Drhl/EuKNwFIrJdZjTRgFT7dhve4vssJQUjd8gajmllEl/QJkGruHpkXrBL77aRdnb/1N3D8xapCRuesQiDs9gVVrW9CDq33p8lKr2WNYT6Pk1AjxcOs1/jKXxoEwjVpoK3YgSutcgGVOF+z9yNGo+I50ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768806; c=relaxed/simple;
	bh=hqgYXDY6TzZevCdFyLY7v/npBKaFrlvSormMKn5uUHE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JUT0kPCcMk3gdWlHErJkWGqLs3rn5vAjVxkGoZsr12HOq+jDhy7GfBaaczSYBQ2zuOCTN/ru8KouUlEbxf+yBo2QWyxdR7w5ytwKHJI62/UDedTXZr9UBuBp6pyYJuJyczDUhOlaiObA8Nfhe1e4FoZwYvF1+syO32WejWUJ/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo50802775ab.0
        for <linux-hardening@vger.kernel.org>; Wed, 05 Feb 2025 07:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768804; x=1739373604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwfpopQ/GSunx7RndpriOuph3YS++0aV3tSQqN0eZjQ=;
        b=KBHmdI5tqwwl+FLNZEZwDMN1tMceK0l+8dFc9fU62jQ4oBfhkhlAS3eStcgudVwiOM
         cFcD+OuLxZIFNyP9PxCkCAQOuj+D3k7Bn8Psmry+UCNBoR4greGX09LCdxC5ruwFbiLd
         ABM5ofJciomsCD0LyBR8KC/W/2uNvUyIm2MApb85gqKSS/d6loYDIQOpqmpNnMuuudqG
         9wXupUe7UCWRvmWA3kGAT4s2hi/QQBq3A5T+96aTgyNllfSAnHhuYhBTh1o3OAj7Lmu0
         l+flEL6NCRF1+bRWtX6YmCy8+/vFLqH+B4keP9+8dRAviFEdk4uaBWeOL1GvbQmNWVQz
         CbCA==
X-Forwarded-Encrypted: i=1; AJvYcCWD1rBXjLQdi3TUFV934XL1uwTY+TxOWRozDxLpHbSHpA4QHzGi+Y5AjGPe7M9EgpqwTxVU1X4CPHi3jIWkF+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPg55UZALNGdpfxhdD8GKCh6qjJrk+gMK0b5+0rQ2l7o3GvpUs
	kmxzlKxnsFLj2WEm/Nl4fQoS02/yPlksDUy7Wc7hgA4gxlritKJeZrzXYTgtGcaplb3IkinDzlj
	Pu7XRA33AU6+fdlTZ1Ikg6/Zyg240oDrzmmWqEqbDjtorHCrXRhWvZ2s=
X-Google-Smtp-Source: AGHT+IEAtMyWhc5FjQBl7fNf+RG9+3+k4csokK468wy3XoMPJxa1oht+TadSAGEbUT8dZoFwHwRU34B/M1moUygTvog7kIyr6KzR
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d04f8f6fd6mr27900355ab.15.1738768803837; Wed, 05 Feb 2025
 07:20:03 -0800 (PST)
Date: Wed, 05 Feb 2025 07:20:03 -0800
In-Reply-To: <zv5u3q3m7t5yehblaqnrcz2k73yozpx7nn5mvbkedrzw2jaowf@soiirioxlfbz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a381a3.050a0220.50516.0077.GAE@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
From: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com

Tested on:

commit:         5c8c2292 Merge tag 'kthreads-fixes-2025-02-04' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108993df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=207eb10d2de1b054
dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112ecdf8580000

Note: testing is done by a robot and is best-effort only.
