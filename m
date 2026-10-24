Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851966;
	b=MvGqBDspjMrOBU2CVBhO519E2RneDrK7FdQdq3iaUatv6+I5YN+dPGCwUdqqtlOm8k4J
	 O13Dx5L63TjGJzWE5QHHfakX9JmKHE/1mlQ8euRNYqtJluejnG3+DFoehzh1tmCTAhuCF
	 +0A595/nrsHNyBNyeoB/KtjthWtRTTTj7enm9d2QdSwEHxD6xDmIX2t7R/l/3thso5zsh
	 pcC7sx0zJwn1l9+7pY+O2/D60kA+mebGTwmshVFwihAcYOsogWPQGFVJ3Lc0rDa1qi6E0
	 0qyNaz7lU3OzP4kIvJQCz8c20Bs9n8zxtB2SGbLxBbU2pGHcFwEwFiefbKO6Pk8LidQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QYgkOqO9DCagcN8giHA3Z4Bn0QqEAyxgbRKI1vfLIiE=;
	b=2j/cX+7nk0NsCLNyPFy4B0zmHGqCyscQJ9YSZoUz7qDfSg/AqrcTzdf0lWqUXiKN9C4y
	 r2bI93HHWsst5P0CvY4YHIOeuDxPR2858cVwDiX2vadC9sCwut8tFU0e+5XT+hG1Lmbph
	 hayvWAQMyx4T8dab4cKgO68WRoxFLwYun/WZTuVLoZBn98nmq/ildYxJ37OYQUKnX1CAR
	 ADRcPzeHyJVFsbmMaz2tIRXLXZoz05UVrYsjuVSer3NHKzSBqVCOc+X9/DH07H6qv1oDs
	 rO4gJ9PKQ84oiF6e/URFQrawDrbziNLrqKSlXuVqPpbuEy+DbH58Mwz9f4FuRrl0o8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eFg7piYU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S9Q6O+9h;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FA606A31A
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eFg7piYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S9Q6O+9h
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8o4142217267
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QYgkOqO9DCagcN8giHA3Z4Bn0QqEAyxgbRKI1vfLIiE=; b=eFg7piYUQmU/lyNi
	NxQw4rol58Y8qyJX+gKvD72zmYh86B/z49D3Am84LnXyUTk/zIZd+QyG4nbyTtZ0
	Hv7TEDTGadbKoLpwcnjBrCjHvwLEGzpboGQlxRqWerme97M6+DmF5vdwx6H95yMg
	NbdUsoxEHt6kjxUhi/vwxd9IQXI9nqdjX6/m97rOMwDMrIU2WS1mly4ZGMa07Xq1
	l2vZJcwkZsa4GquJ/LtEPIOMUSzL1/G6qKPtXiyBVRShT5rsj3btvZHXyeer+y/P
	0aygViyVoj95wr1WJ5jDv6v2RV0QVVOSaKV9dpksSvMk7oJVcNOhc65bQsIrlNn0
	FyEhTQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgsegj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:26:04 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso4201793c88.0
        for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792851964; x=1793456764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYgkOqO9DCagcN8giHA3Z4Bn0QqEAyxgbRKI1vfLIiE=;
        b=S9Q6O+9h6ZiV92iNkk9+LYOnN9zMSGy3Vh3VrsAa3SUunOfH9y9+ggFPZZ5mn6GnIn
         4YMq/9fPKyaeBJCUoaegddD0/3/sBch1Bk8CnWmP0yHAHoP1ZKjMEzSdDgb5TUkeHadl
         HgL6GZu76Z49Ik0ldR0ymM9zpz9W2hCGHuUAs7KLimlOrSuKRKR9h1KPXYvy/pq2QXik
         ogl2XxqWCDzEarLsYg/NBR2HNe3bNlsnqVWMF8IrJt3VHeGkSf+QdZ85krjMMWsINvCs
         JwTntGuRpIao7EOZ452ceU8ccT/kGfHmbDLig8y6Iyj7pKEFpYSBlO//QI/rqPi5KIso
         RCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851964; x=1793456764;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYgkOqO9DCagcN8giHA3Z4Bn0QqEAyxgbRKI1vfLIiE=;
        b=NxNMgdqAmSy556rtjKA4eUxul5h+fMD+jKke/T6ws5ZiZ/ADZDvLx7g6ZN3M0WJYpN
         RPW4ZS6oh7sT5AQbRe1ZH+HkJTx6muHocA4CDr4+W69SNi/aKyTwBtpZdfCUy0CQQyIH
         Jqy6QV5gFKWLGE3GJry/hIXcLY7eq+s8dN7e/1yzvTANMopl4HOGi/wJDJlonAf21pJv
         +90X4wdQMoZOK3Fc3MA75UsSO8ikw6F2Ekh0iIu2FBqMIIZ4dQXfw9Cl4q050YeP/3kI
         +1ytHiNGrMUsWf3XBtYUYDKauOlfVVbkrBKtKPf3iZAl5tc/CHjPOwbSSlfpirbQgM+Q
         25/w==
X-Forwarded-Encrypted: i=1; AKwUvBzp/6jyElJl7nczgYrTfSjoA9+etDHDmKrqlLXN3K1UEbAV/Kp+39+Rqlgd/5SojodHXgOlJnqo/K4N1D0zRnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG4kO4e9sCgeFT4TdDwqu+Wogfy24rYphO6jLbOQRBcWadWBYy
	yAGx/eVMK4b3VgjW6dGO2Kg8c0gXj9yiW6+GkEHV9WorGB4C498suzHOUdNebPJ6sKQUIGhCQhm
	eIa5WRoR6NoYqG4siYNrPNi+Dlze2nX8HDMNBhOocMxHhk2Vrks1eF0j56sSZESAewO7UvLw=
X-Gm-Gg: AYBFou1su3LA9By/n+JG20/fbFNZ6SQxyNsp41Cj0k3WcCwaMhHavAFGnXBziaxuzLo
	OIYR25KBZfHsjK+4CWhGNb6F1aHpN7T0LmUDKzj9kPWP1XPmQpYK7rzrJiUIFmwPXoQnyzTfvfj
	IsytQ57fKHGlc6oA6YJeonlD7YxiguL3NexhJIWAAeOZqwZQ0V4txh9sOtLuNN7wGVOB17theO1
	CN5/EE0Me9jaBM39VN6ArC8EaUF3uVpTpDNmdFRJ9GrOsyv0GWCMc77J2NqbrGY5yci1TZkbIQy
	+xey/srO6vpcioXQebVLJF6LtCeu/pHbSpihVb3Rmfcb85qxt+0duiQPVSzrq8PSew4QA9YNqvm
	NIcPm7rstQftNww==
X-Received: by 2002:a05:7022:eb57:10b0:17c:a0c5:8c9a with SMTP id a92af1059eb24-19936e39957mr3072312c88.42.1792851963820;
        Sat, 24 Oct 2026 07:26:03 -0700 (PDT)
X-Received: by 2002:a05:7022:eb57:10b0:17c:a0c5:8c9a with SMTP id a92af1059eb24-19936e39957mr3072265c88.42.1792851963055;
        Sat, 24 Oct 2026 07:26:03 -0700 (PDT)
Received: from [172.31.0.30] ([136.59.194.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a470sm7004586c88.2.2026.10.24.07.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 07:26:02 -0700 (PDT)
Message-ID: <777f4cae-6945-49d1-aa6d-79ec6b40db18@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 08:24:47 -0600
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
        Richard Biener <rguenther@suse.de>,
        Jeffrey Law <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Uros Bizjak <ubizjak@gmail.com>,
        Richard Earnshaw
 <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Juergen Christ
 <jchrist@linux.ibm.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira
 <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-2-kees@kernel.org>
 <65c57069-0f3e-44e0-9562-8867548a7443@oss.qualcomm.com>
 <20261010080449.fe2893-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffrey.law@oss.qualcomm.com>
In-Reply-To: <20261010080449.fe2893-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA1NyBTYWx0ZWRfXyK25UJ3ZLLUj
 H4/W3hikizypg7eVJwMTE1SHaXXCcD+ozF6o61+ixOLNtSLFgpUmjkswafk1QzrhlCgSwB+cvtm
 NDrfGVeivhrQOHgf7BO8bXD8lftOfq8=
X-Proofpoint-GUID: e9QN43YwECKWUx4rbJ5o2SdxpRY-9yC4
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcbffc cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=f0mOnocCY+QlKk/R9FCP2g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YIYIA2ImUFk9vn_Vc48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA1NyBTYWx0ZWRfXz3wHveZtNJhf
 GFjsnONk6UxQZ3Z8Ha6D2uaEkPkNCSFbDHQ6FQ524ytPKn5QD2tHH6/75SS5ObgTxKCqP4HTjWI
 Ro3B786cnn2h7csQAn8IUtG7I0z2Tt69CZfd86w91ZwjeGaog7N4ECRaR4t6YEIsZig9bhxwRlb
 Y8rZZIvOf+49TkLbN5+GM0ytC7FDhOIRwU3zO3QK7CB8+kjI+10p8e5MHVThiNY9gLiQwoUk/Z0
 2DB4DuMDoa2w7zJmsaxs/w216NJLc9eOf3iKDr9/2AWLOTw7uQpPbecNdl1tl77G6kJ22urEhw1
 mMA+OtJQjgWKRvRNHu3K6xdsLr/r8vXujjH2gLrkLVngkb17j0haJBp4GJrAVnD45d7z3bL5TL8
 BcHjtIigDfrJsLkbm8rhdc9OAd7ozkuOF2U86NzfVSJ/b2jnPuFA9Xsyt6lKu4XWJ29JrMj2OzA
 4TqsxklZXKOiVvF7+xg==
X-Proofpoint-ORIG-GUID: e9QN43YwECKWUx4rbJ5o2SdxpRY-9yC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240057



On 10/10/26 2:10 AM, Kees Cook wrote:
>> Pick one style.  You've got the parameter names in one prototype, but
>> not the other.  The general preference within GCC is without the name.
> I've fixed this for v18.  (I'm used to the opposite in Linux: everything
> has parameter names.)
Yea.  We're not as consistent as I'd like within the GCC tree. Hence the 
"just pick one" rather than forcing to one style or the other.

>
>> So I sound like a broken record at this point.  I see the assertion that
>> it has to be an atomic unit, but nothing about why.
> Yes, sorry, and I've answered this in detail now in my reply to 7/7. In
> short:
>
> 1. The checked target must stay in the checked register until the call:
>     a spill and reload in between would let attacker-writable memory
>     supply an unchecked target ("pop %target; call %target").
Understood.  And this may in fact be the biggest reason.  I'll ponder in 
the context of spills.

> 2. The trap isn't noreturn: in the kernel's permissive mode, execution
>     continues from the trap into the call, so the trap block can't be
>     moved out of line.
Yea, but that's easily solvable.  We'd just define something with 
similar semantics so that the compiler doesn't think the trap halts 
execution.

> 3. The kernel depends on the exact layout: its trap handlers decode the
>     instructions around the trap, and x86 may rewrite call sites in place
>     into FineIBT at boot.
>
> v18 will add all of this to the design comment, so the "why" lives next
> to the assertion.
Right, but we can handle that with the right barriers around the call to 
force the exact layout.  But given the concerns about spills, an atomic 
sequence may simply be needed here.

>>> +  /* Ignore cold partition sections: cold partitions are never indirect call
>>> +     targets.  Only skip preambles for cold partitions (has_bb_partition = true)
>>> +     not for entire cold-attributed functions (has_bb_partition = false).  */
>>> +  if (in_cold_section_p && crtl && crtl->has_bb_partition)
>>> +    return;
>> Is that an design decision in the partitioning code or is it an
>> implementation detail.  If it's the former, than I'm inclined to allow
>> relying on it.  If it's the latter, then it seems we're just setting up
>> a ticking time bomb.  It could well be either, I don't know off the top
>> of my head.
> It's a design property of partitioning: the cold part of a function is
> never called, only jumped to from its parent. A function's address is
> always its hot entry, so there's no valid entry point into the middle
> of a function, and we don't want KCFI to create one.
Duh.  I should have realized  this.  Crossing the partition is never a 
call, it's just a jump.  Presumably you're not trying to protect 
indirect jump targets?  I've been out of the ROP/JOP space for years 
now, but my recollection was that indirect jumps where just as 
problematical as calls.
>> Given we can pretty easily describe the generic call setup in RTL, how
>> painful would it be to instead do the instrumentation in a generic way
>> rather than twiddling each backend?
>>
>> In that kind of design we'd force the target to provide the two marker
>> insns which mark the beginning and end of the atomic region. Target
>> independent code would be used to load the typeid hash from the preamble
>> (using the offset the target provides), compare it to the expected type
>> id, branch around a trap-like insn, the trap-like insn itself, then
>> finally the call.  I'm not demanding this rethink, but I do want it to
>> be at least considered as a design question.
> I did consider it, and tried something like it around v2. Two things
> stopped me:
[ ... ]
Thanks.  I could probably argue a bit here, but it's probably academic 
and we've got better things to do with our time I think :-)

Still working my way through the other patch and I still want to think 
about atomicness of the pattern WRT spills.  I think we have similar 
problems in other contexts and I wonder how we manage them...

jeff
