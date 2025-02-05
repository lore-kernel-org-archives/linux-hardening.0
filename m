Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38771FE455
	for <linux-hardening@vger.kernel.org>; Wed,  5 Feb 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781586; cv=none; b=W51ExJBaiN0TT+1Nktbm9pY/4sUaa0NcuCmpna4i5zMPHQVDORIk+8iRdIQ4Y+bfc5REKsJ8mkSMMv1BbU1kBS7dWCoxNbeP2AoM17EMjKnZgDoOkAbzye5Wm5Y6c9qyrBo3DGun2hPxfmG0YrNXo8+3+RTlkVVDP9TnqtkoyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781586; c=relaxed/simple;
	bh=tARMrWWTRtWys8PMKiHPgERjW0g1foV2+Wk2DGBu0Eo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JNXyCbDMT75+0bHN46CQLadtqh4OVHod8HKCP4u4dw4XQnToaM7pxonevUImk8hu8NbZaVWUJBeLIVTxDOoFRM49dr/0ebMp8rdu9vVy/tqio02OXh/uMOcfH1iWP4nT6auW9VM4CRQFRyHN2e3ZFQcTPF4kcv2rOwcf8RWlJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d052db03a6so496015ab.0
        for <linux-hardening@vger.kernel.org>; Wed, 05 Feb 2025 10:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781583; x=1739386383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDYV7j+0Ng3pBdeYSpKXURozsltAjUJSfrXA0FKOfCI=;
        b=RMIUifuf4BY0b3FHhRg9ovm4i9IY4/mdUiY8PnZbaSITPj32Ii87sI78ibzeobwFEl
         QkScQz0TKVW7qvjPVRGMnyFlJ1MvCRN5LMkiywQIAR0Wy2Nbw33Nh4vvoMzYJmS9hRX6
         SHzIXw0O/FdB6STQKsNEwpJPmdGYOufR6nwOeGmlWI4TZJJScRngsqZ2/E0GequYVZye
         7qH0jq+bYGd2Fpnih/IKMXAudThV8Vg2OKXrOPH33yOlQyZYNh6evJoIB5V+015trEU7
         TElT6QMW2IB/exs4ZzlQr1VZlnvy2mD00JvcdinCD/J76EOydL1jG6MZMonVgj3dvrUX
         it7w==
X-Forwarded-Encrypted: i=1; AJvYcCUn8g0vrOlaCjVxlATjok/CV7v3dp2q59z+2mTKbSWWkYq7FI22JvTY/JK5etnljFgaXYDFiECu2vmMr+IejGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz786LCe5CdIqd888w6jGjpLJgTsafhiOBHTkJnagL/7oUapgFz
	ra2cwubNTSWC4wBrsyqNgY8C3BWPNDGNFtuL/xwhnKMOAp+zKQS6M2/QyFCt1tTdTy5Cj1lKOVk
	zMwWj87dHwrlehoRd6c+DpEBrsWIgKhTS+50leZLZN4J4Ar1cm5UHcUM=
X-Google-Smtp-Source: AGHT+IEhJWeKOTmZ9PeHLjWCvfpb95n3CovTNjj5uKj5kahddtxpg7508wvgYjmxvMuvxjeEDXYHbYA+oqxj3rTamLCovc/dIMjw
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:3d0:2a04:1ce2 with SMTP id
 e9e14a558f8ab-3d04f917778mr32567125ab.16.1738781583104; Wed, 05 Feb 2025
 10:53:03 -0800 (PST)
Date: Wed, 05 Feb 2025 10:53:03 -0800
In-Reply-To: <r7aylhww6ssce4uk4drib5c7awf6kcdgo5rzorbi3mve723hu6@6p7ij7t44ejq>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a3b38f.050a0220.19061f.05ea.GAE@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
From: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	jack@suse.cz, kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com

Tested on:

commit:         92514ef2 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1770beb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=207eb10d2de1b054
dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16dde318580000

Note: testing is done by a robot and is best-effort only.
