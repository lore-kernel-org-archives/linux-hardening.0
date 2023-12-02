Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YA5NcrkM"
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C9134
	for <linux-hardening@vger.kernel.org>; Sat,  2 Dec 2023 13:22:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b34c5d7ecdso124256539f.0
        for <linux-hardening@vger.kernel.org>; Sat, 02 Dec 2023 13:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552141; x=1702156941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=YA5NcrkM5udEWaHHh2G+rmz62ChxvRvmbuIaxK6S0HmU0dsnoYprOaEiaJ+Bbj/pE0
         X8/WCK0HfL43CDLXxWRUeqCFrVa9Xk5RwQEO79zs3ktain0CD+LqjL6cCUM3uEcRVFcX
         ADZbHiYgQnmAcZWmNncFbgqi6QMwCHkKl+XgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552141; x=1702156941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLvxvckvyomlZOIIg4Wjwswvgj0BL428CVO+nAzlFtE=;
        b=Fct4B7Lrle/vkkk4MgERonMpE+m67oBS9oTL7mI0xCabo2g1l7bBtQ/gxRjM4448p4
         OP8YT61wGidtFu0riPK05Uje10JCKvSGPVmUqWVL/SAmgZO/6azsDGPcpSTt8z25ob7p
         GuVBeF2SwL0lCuJn37qV5lv1lX2ca7q2q5hIWODL2N8h5pQtQMmOhle067Sr6EH7X5EH
         BpusOxonjbpfAPy3NL2pkUb+BcIImT9dGyMuQXGXes9mHTIl7/DARLmSFrc0Wqx6wIZF
         NZehjuugsw98uA1n+u8jPZvaWiKhdKjsoVx/osbm/sJuzp/eHbEQEzaGjks51rL8QY6c
         oMIA==
X-Gm-Message-State: AOJu0Yzed8C9af9rBCNibo+UYqEbJiIA1s8BZ/9oJERd3wfhpiwicLB/
	20MKwyPlZqaVvvo7sQv5bphpXQ==
X-Google-Smtp-Source: AGHT+IGtRLKSAKTdisrEu2j2CjbfWn28z6XUA+T3NZsmq5+CR4/UtQweJAgLKCPRmDEaHRBtmwe+zA==
X-Received: by 2002:a5d:894b:0:b0:7b3:9256:628f with SMTP id b11-20020a5d894b000000b007b39256628fmr2310006iot.15.1701552141318;
        Sat, 02 Dec 2023 13:22:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001cfd049528esm348997plj.110.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Date: Sat,  2 Dec 2023 13:22:13 -0800
Message-Id: <20231202212217.243710-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=keescook@chromium.org; h=from:subject; bh=Vr7BZE93w9hrA2pgUGte2wnKY/rdltDnNWxbve4aQVs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGSav5RcGFsYqI8ZI6gPChQFnsbC+3nI/Sq AQMSCvSeJuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A Ji1PD/97nsFeEYnRWCY5ijYm3HvFHnw2xsSeLfCgNERlEsvkDTZnVu32g862lrZ6hmNnj1/2WLY q5BTXJyqzwbbUg83+V4Z7IWpauoICvmh5nWCVw+d1swRjKLklznh+kH+lxKH782U5N+1W/bPv70 NdRhJBCPVOIeyBMGaFNtfbgw7Q7/MKTOSU/62VCry3sVE9fgDWP9DnB0W9/AVEf5mttk4aI+XJP Jf0b1606ZtWwo4iih+TPjLRID9WD2cRTVsaeRdH6h2sVpbIWtLfBMYm7MUT4xvIE/X34XC1XbGH /mFyNY6PyZyWNI/tRahhMjKTPtLuV+I51o3tpDU6ScYTIbUYyvn1SktT2ZE2PeBRIK7UUg8Kekf uMNNH7+hll0EcFYUEBOQ4ErCJ6guTCAIxc+68VotsoujHUSgriM/jZWU+UdawDQmyw5w2Zxt2fH io2IkOg0NktS5Lz/oNbESXSgqAIcAsWZYdpz8f5sULzKfDAWY9NZCkKawVLDlwQ3EVVq3ugJ4nO /+MhL408XJIGHI6nAbKY8QyfaPWyUeqbflROQiQEI6UVXEYbPuKogAFFyNGXqSlpZfzWjwQM12w tqybXEWAcWdB/zgRVWCl3j9u393bvwCn78YpxLSABa2mDjF9niWPVYIK3247bi3TGEcoqVKm7/q lL7bpxiJe0Uvk7A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Allow __free(iput) markings for easier cleanup on inode allocations.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..7c3eed3dd1bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2459,6 +2459,8 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+DEFINE_FREE(iput, struct inode *, if (_T) iput(_T))
+
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
-- 
2.34.1

