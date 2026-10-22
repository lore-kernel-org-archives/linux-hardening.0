Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635520;
	b=foeyueUMjCUN+/3OtGPGGzA2NWT143zSOJGFL/oQ8X/v6PgBjaKtIfNwC7RBOcM14KIq
	 QNCbcZxlQtiU3LKbS5sLaUF6hVHNkXuhDKHbz4dm3MliAaSnusBEuucWZrNwz3n4/XWc3
	 Ls39D1YwZ9ysxjsMvzoPeIzu7dCcEYN1tjzQ/cCqJDEeGDWxN90Mu36sZ6WHSGnjahDAZ
	 6jgIawTCh01dmuBAGf/sPOa+s9LKW+j3+nZ02VrcRWhTDDEY9W/OeC8sZjj0D33P/0Ypf
	 Zjs4FSDJY1kSGQ8ixEboPKv4FzGDraTj7f7QtCDhGAwB0ttGVQjdyGT7p68oda93efA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
	b=ECJGRgIRH4oAi1Pvl56iDzIrhVeKzsLfzaFz6yRQKgAf2TDk8kSINBdNjpek3e6/DQon
	 E5DyBxMrZveGRnulGDzD2OsjQiYDZkfdIRq+NbJL7g9VSuIHWzCIIQEjY5tBp9bD0S4nh
	 u70yCiXx9/VTOc4T9bSTYwNSeA7nw9SIfSOTN/8DX/6MNTmVvx8Jt6S4I5Bh/1OJKOlOR
	 RthAIHfemeahw8GlSmhkGafiWDrC9dpCLjIfpExJwn2P3HZOQzePZ6W75mkVqILdp3TbE
	 Tf8Wn81qjs8nGCV+bFm1ryfBq46lkz/dKbGTXuojf4CL+3Jmgl8YAQoKlsGA/tF0jOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H+eszt1v;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA873606A324
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 02:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA873606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H+eszt1v
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so3733922eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635519; x=1793240319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=H+eszt1vKQtCU3/KB7Qzaij69qenfu0lG2XuIF4ZWISg5dYrkmC9asbrjtgR4CXkce
         TBXb4GKHG/wsSGQ+UrZ8+zEcA1NQgtYK91w+B80ULkg3ASikYfCo9UWfYmfwpvEte4XE
         jTTxbKPQVXpeU8ktIhq/YTivJtLdLSAXqmVf38FDGxukqYkaW7iUTpvQyxAALnq6XXGD
         ci38T/qydDnsRZLVQQuKo0hUWVY5R+df+t/heaKrcLMGs9Hz98Sz5r75F5L7LBqWlFQI
         egjfA+nNUHRlxwEXpwXcYyyWcLr+UjLA/NnupQKuiAMqRo8yIe4c9Dms37/DiCtx6ifF
         hfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635519; x=1793240319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=0pYJwVDLJRUFaFTCxOEjQxBMcrHupFaSgztOZIZttORzJIuqXT4WejvDVLCQc/mMWI
         d8fzAZAezbL6XcLyeV0AL8MKWNOdLCrOkqbUAwNzSbPHNBLDT/Lt3L37mwDoj0eYXI0z
         HxmsWDhGaFtThuVrntPTzvKOxcS5ljxHe+2JAP7Jaw80C6yIdzu2n+P8klysOs8yV4k8
         gieBYaiH35ZOmzCrYLfYRx8ydkSBzVklnWj8hMucpSLljeB9rVTwzXrZqWIgqH4cD1jq
         vfJMsxSfEi2uRWXVXhd6XLmLFCOOPSX2Y4DzBCXYYK/M609oEN2sSNu6DZk0dqkUOYRu
         5+nw==
X-Forwarded-Encrypted: i=1; AKwUvByoWqHlvkShflFmiEV9EgFYuqpfBBlsE7GR2ISvbwJY5k/Zy53jJ7vEPmtrCrMuiEAaGWcK0QegCmTHbCyO8kI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuQHmkRYj/qcybYxHQ4ZuretqUnxeiWaZpo1mX40a6IERIjAjn
	tkNKBRhpk20Om5tJKp3UGzI6x8FZt9dt6jNq7mCGKYToeeY8JHHTlrCJ
X-Gm-Gg: AYBFou2Ba2wJDoMROpP3ozxNLN8o/HXlUCwJkJgxFGBv5No3A2ST+2sbyLqrJL0GgTa
	MxPCksE9R3v69C5XEz+Rs0vKJnrq30dZGW31xcAdCKTrhlyyWqBGgEKvSDgmPmABr2lXIE9pq7W
	0sVOWFoW7LfE6LIDPmW94i4S/PeCEkoTgO/iid5DgVTVrI+y06zJ/j4YQc3p1r+LFusIOB0NDGa
	SEqdVeZ6QetmMEzpyxjdldZtvgcn7ZgvCdu/BfgIMC70MS1MNjO5lUYairuvcvQf2uv1f+IsX9x
	+Jg2CshwhUef5WYhe5iDiWrDodiOl921B5FNEeMn76qwLCKF6EvkXoG6dNDiDxahLO/iKA1bfOq
	X2Taj+RBCGo27UjSO9CqqQr1omxoxbgNg8JG/SPpHRVcLF6TsUddftxjOse9TCf7p+3hLVIxCNr
	wVPH0t2kNQlMdB+h6mcBBBIxKx5ECrIonPDnX6nDhTzmkGReNIU0x52l5xODUaeG+iwXVQ1bO3C
	ITfs4YLzL/OpwzpenHnKdKutdmad2C+/+RP2ddzcQ8qv88=
X-Received: by 2002:a05:7301:618e:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3674c63d579mr5523810eec.10.1792635518735;
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368b4b8e9c6sm3556805eec.1.2026.10.21.19.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Peter Collingbourne <peter@pcc.me.uk>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
Date: Thu, 22 Oct 2026 10:18:20 +0800
Message-ID: <20261022021820.1789083-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com> <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com> <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>
> Why it's open-coded ?

For the same reason as read_word_at_a_time(): commit ece69af2ede1
("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
it "to avoid having to pull the entire instrumented.h header into
rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
instrumented.h with linux/bug.h and kmsan-checks.h.

Thanks,
Qiliang
