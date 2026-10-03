Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778263451A7
	for <linux-hardening@vger.kernel.org>; Sat,  3 Oct 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009146; cv=none; b=i/X2rFGXALqMM35P/P649NCGnV/8ZuvuvacAr84S0zBtNcLY+OSspzBKEoDnAL/35GcdaArORc2sHkXcxqMYdg/pJJV1cLa4F/RZngIYs0YpxV7Gr8Md8af7755wqJQ7RtfkqLKMup6Zd0AL1voaxUWWwuT75Kmy3teQ2L4hXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009146; c=relaxed/simple;
	bh=VuiMGsvrxoxHYIMjTtEAMKJLNMC58E+oDp1FFjB26XU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=dyAB5+YPK9KLyhRkb6RY1+RHqA57NSetwksESYDkKQb3An4hlxWwKkG0lCvGJqXXedQyycbWBFCQ9fYpVc7QjQdFjw70uUWDCdVLdarTPHdmrAWRmmCQuowcW6A/bkSnuScafSRYsKO4HdeE6sc5+6JuQpcViBmwdlHtOOe6OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL3guCmC; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL3guCmC"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so91950a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009144; x=1791613944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=DL3guCmCAoGGad5fqQhT+5W2N60ezuvD94VtFpob8EDuN/9oZNMQlKHDpKAkIFeIqv
         cOYuDc2THo5GGGolhJh0u08uEpd/a0aW2pVhSbGM+DGfgBTDKm22DxkQ6LX2FkKiM7yS
         jJV/jTe/NGZqAqIfD6TfS+NvtBajMlBp4v/HObTFUIzWKLyviiMPwG3ZAouqLj26zAwG
         ZcJjzfa+1isefTBiR26J43dKgCqETQBDF8CPhVZde99KZyOFaecA23+M4lrbFKXIXN/C
         dkTOqRKnWejNq/nzi8KHvYZV7R7OXmRw9eMk5898z5VOh6iUMuXoiZABMloEUTphOZXz
         PHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009144; x=1791613944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=fRbXzah3hve8uCGDeUoLXnixGVcAsYxys1/EkjzqeRnvO+8fNnSXaYNAWlVMOIAogt
         in3Rcm4Eek4DKh3J8/MNSSl9XuKrjN8GJRyddv7Mxjkar41zoRlIfIGO/BU+pSs2EO0g
         11keEAgZl0rWxcHOMVTkjajg18LjQpw2gMwiUM0nTqUsNDEtlA+4ya4clbvGH8ga/Ov+
         3R1Hnmaalluw2CJgGWA1yABWi1wEBXBAA2B8S7jZsHCk2q3vx9F3qTavccMFw9WLyCgq
         WZTKO7155gQcTrNxDXgmoFhdJg43qR9yQdesOLgTBdS/Gllfbr8M4sfL4bnBMmR+Cjwb
         b7Gw==
X-Forwarded-Encrypted: i=1; AKwUvBwrxE1NBiyt9OSXbGAmiFT4H7nEEBLh73nY+uuIW11k+gUzX0KS4VqFeH3Wt4nAcgvAQkXvqPblzOJgUZxI4KI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQiMwm/O2IR0H8WFu7mmpbMS0shYvLymAWUH/l0kr69+poI4A0
	yworg6+ynznZFl5bj4hFTfDm5bPAksGHf5VnAPEkfCZtlppl5nEBukRE
X-Gm-Gg: AYBFou2cKk4BEnrUBNjNUvce2hFzH19HGZBuhJbZ/yZxXgpnvb4BfnfcxMJ+wz7w8wI
	i7DcUBrJHeRBRdH4TBXrTccjG/fpENY6bLKoL/7axd2Xuq2zWlUP0r8cqxjzdLPHkW/6v9AAVpc
	VbV6XzS8Niz44nLelRTAhklfWsy1IWu8eYWs6emm9ohmns2B9MNL5JFcNe3Ri+ghBgXP5csFaIP
	ttkz38r589wP5eXYuRoGPW10lPR2Q2vagzsEgl2FB6CH83I6XFvXLwC9Gew6DybZVYBrL22JMhP
	7nzaSu8R3ZORKBOuonbWkC+R7jnOV8zCFCLaHwzQ8M66psGQyKLEXDKVnUqR8h5hbZ7Zzrca6Vv
	9lLq1wcUjgaJYXMxHQfoOt8Hw3mpQBUDMWs/10bNMfVI4+iE1YlNqtiwulkDbMITLS6rVCEyrIl
	py5Fg5XYxXB1Bqr4eZGG5qrr8yJ6b9p0gC6AnpX4Og9IhyjwxJHW8DtIMOlUDGGB5DgIZyPEMpR
	dYyBwZ3gL3Zkoa+nDsUSL+o8mpQJlURvcx8MXzWqwk5U2O2bNQJkCmuqaoXWPkNJgegyOn5G57b
	SfRhkTVL95jVkA==
X-Received: by 2002:a17:90a:1650:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3a6e622a50cmr2049092a91.22.1791009143685;
        Fri, 02 Oct 2026 23:32:23 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b5c3dsm1823004a91.13.2026.10.02.23.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:32:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:32:21 +0000
Message-Id: <DLUZR540Z45R.3RTC4COS2IW2V@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Gow" <david@davidgow.net>, "Petr
 Mladek" <pmladek@suse.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Shuvam Pandey" <shuvampandey1@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, =?utf-8?q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Jiri Kosina" <jikos@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 "Thorsten Blum" <blum@kernel.org>, "Alison Schofield"
 <alison.schofield@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Ira Weiny" <iweiny@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] seq_buf: Add seq_buf_strlen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kees Cook" <kees@kernel.org>, "Bill Wendling" <morbo@google.com>
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 08:59 PM Kees Cook <kees@kernel.org> wrote:
>   seq_buf: Add seq_buf_terminate()
>   bpf: Remove dead newline stripping from format_disasm_line()

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
