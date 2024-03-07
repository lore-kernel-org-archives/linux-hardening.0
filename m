Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DE135417
	for <linux-hardening@vger.kernel.org>; Thu,  7 Mar 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839947; cv=none; b=plea4dV2SdsoxsYmV+E4Kxw29GJCXlGWC2MUcEgRUzQIGbVbhX7WpWLb3nSPzSCXqOPRSmTtHyUs3AFGUUKcLAkvKpJcfO5QqZ1OkK2er+gzESmW4URvp13ZtllDc+9K/rnFF93662xo6900vHvq5332hOz54dNQEFyHI+ighBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839947; c=relaxed/simple;
	bh=7GcxakZLq2oKSdXj+ofXzEBmRC7bzIxUkfqgxs8FG00=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tz9Rqx7Y0RfqIsk2J4/8VG9uDdGUz2Sm1j4VvcKkbSrSwpxCpk0quZeBumpjDQCf2xnaDjDVRY6Z1poXdZO1SqVXzcsnY3wwCerl4H7C0itVIP3citfRJui3fClL/mcl3BouxUWUOV8jJyP9y3/J0BNEqirnuXzzSlTN4kxPN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H35LTl9r; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H35LTl9r"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-299d3b09342so915080a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 Mar 2024 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709839946; x=1710444746; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9qoSXzYZPN9ruMFhEGa01LS4BMnI7rAvWb4nFTzmXc=;
        b=H35LTl9rrbmwdPzJ9BEr5gsW4yRvPb0B1ueFvVOAbbFCM1oOUGvMzXBIBjTaInzwOZ
         p1FgntUUc1QUgw45r9wD1UyX3tBagKyGJDc7/EqCUuAgNBWsLfkyFwlJiabT7weDLDb+
         NjOG3U5WmJKpZcGN2Mft/gDtzpUx7IA18poQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839946; x=1710444746;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9qoSXzYZPN9ruMFhEGa01LS4BMnI7rAvWb4nFTzmXc=;
        b=BtreYXfdmWtoNn3N6hCP7x7qAknCHI4t6J+/yzT3bt4u3F7n6lGUwoCjaSUDE9+u2Y
         mcR1Mfs5FcP4hdrK9f1NUR5Al9ucvx2s555+gQOcRgIUmhDO8v9uClbY655/RMpRwQII
         LZBM+xglytyZmQ4WbDsx6r1eMms41JUy4bGw+xACKGKBwF1xnYVR8nFP1gcloXSv160X
         dOzoT01nOgR798lVtWz5upvMT697QRsPbKceeU3dQkuFvYxKNDz1qVEODGZRF0uTloD0
         x3UJHako1umpJ86MkJ4PDGjN8YhvXL637ZrgG7w9OL5hLzApGJvw7X8jR2RqD8NqbH2x
         cHCw==
X-Forwarded-Encrypted: i=1; AJvYcCV2UwJVOQt3r8tN/+FYenPBrqgdOE1GAJLWIzAqBRLQv1TpoXqbLiLWv6g6hduyz3Hw9WlQwo6C6kt3kQPr91lZ675VLrWHm/ACEm3Vmcz3
X-Gm-Message-State: AOJu0Ywm2o44tkVfeKmRd912eK3erpBI4Jho6y4WZ9SR/dpLi/PwAAvd
	vDGkWaC7hozA7wBiW3iMtIzclrjHKknJqOqfFxmcPPOrcosmbsDGyKxSoLZTDg==
X-Google-Smtp-Source: AGHT+IGOLBi4Qz9QnVx9qVdy304kZfGTtm1ed+Ruod8ne2tyM8cAlmd20ukwkMkoXTBqPPYmDqQq1w==
X-Received: by 2002:a17:90b:24d:b0:29b:9c8f:5ea2 with SMTP id fz13-20020a17090b024d00b0029b9c8f5ea2mr1766760pjb.40.1709839945732;
        Thu, 07 Mar 2024 11:32:25 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090adb9800b0029a849e7268sm1908119pjv.28.2024.03.07.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:32:25 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Thu, 7 Mar 2024 11:32:24 -0800
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: __rds_rdma_map(): Null pointer dereferences
Message-ID: <202403071132.37BBF46E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20240307 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Mar 6 11:58:42 2024 +0000
    c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")

Coverity reported the following:

*** CID 1584247:  Null pointer dereferences  (FORWARD_NULL)
net/rds/rdma.c:306 in __rds_rdma_map()
300     			unpin_user_pages(pages, nr_pages);
301     			kfree(sg);
302     		}
303     		ret = PTR_ERR(trans_private);
304     		/* Trigger connection so that its ready for the next retry */
305     		if (ret == -ENODEV)
vvv     CID 1584247:  Null pointer dereferences  (FORWARD_NULL)
vvv     Dereferencing null pointer "cp".
306     			rds_conn_connect_if_down(cp->cp_conn);
307     		goto out;
308     	}
309
310     	mr->r_trans_private = trans_private;
311

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1584247 ("Null pointer dereferences")
Fixes: c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")

Thanks for your attention!

-- 
Coverity-bot
