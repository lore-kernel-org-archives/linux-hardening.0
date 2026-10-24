Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853032;
	b=vgrZV6hGqEODei0teIcLjHIzhBCh9kD6iiEa5NLRYKlRJo3MY07MT6mKH+a8gEkkWE5W
	 N4TfyKrF+gAOxdgOMRd8sGD/euumcU/PMumxTxmsuC6MbW/5cnlEUqtP+eWfmpGDPXSba
	 UKmrpksM/3p5+DjjeWW7GhSZKK/BWaAx8mAc5PuqoFWlZrQUD1/BAvAj4JrKPI9neMhgd
	 zJlVv0GA0QupWgQZgro2pkh0lnA3YoiR7JMPR+Gua+eZlo0HuO0/Xrde+FPG1btJ/SgBU
	 HIN6+aaFEz/7QAEjCmUSriefCti0PxY5aiiNEEHrTgi4M93jkfr19x5aF9Vy81YVPFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=buu/u8BY9uW1h69ONwjxYkzcoMKDwI8LacyPISak76M=;
	b=b+myAUl+sZzlocjooJmBnyDKWPtdnBaadoN0asXn58L36l1ASS0Zqi0XrIphAqfCrMbB
	 9Wq4EHYRORs25wMQ229fJrG9MFDxCUdJEINmCjy8m7O1rwfkFXFo3DhunQ+ZsUjUWUjHO
	 SGzEfW+nK7aolv3qCmYTBJ6vhu0N6bpwyqdVPwTTdljJAHa3VKfUzSHrxPrerI7vEJu8z
	 zqvtd6hgNDP8oML/kl4koFtr0nwkk+yg8ICzZb0UwVW0Ga7UvPesmLoRd+SkOW+w4vYT6
	 lc/1LfygwPkGIWOe0Fu9DqjiH9noBIXANLLQKXALvIG0P2uhEqrzG+jkV7pyl9k5auQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="NjG/yA4d";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMNCfPYo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF311606A31A
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF311606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NjG/yA4d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMNCfPYo
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8ntjZ1706406
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	buu/u8BY9uW1h69ONwjxYkzcoMKDwI8LacyPISak76M=; b=NjG/yA4dSM9mwgGx
	bxDZle8gNUN613XBtvFzvLbifhAZvVHqnAmBhQGm0HQ5OyesHZGzU3Jxl+TW8AM3
	7f5IeYpECD8ZuFdBwzkyNMfNUwdBS6CPXCDhzpCym7cU26BW7eC6NTdrqSNgHR8D
	OoRSnCNexFSzFLx3YI7aMWoLBBn046H7oz0sXS4yAeOolzMgbbQzhkev5LMpRi1M
	QLnuITb6TI3WJin+8Qo19BRM/pnt+wEPG/0/VPDujNXDH3eSf8AQmKQTv9wsmHcb
	M+SR4AmQybxK4CJL6QJRBGf4JQRZeiDJlA94BGZ/Y4D7tytLivGqMi2qxDZv/36c
	bGf1Vw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xh6xh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 14:43:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so4623839eec.1
        for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792853030; x=1793457830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buu/u8BY9uW1h69ONwjxYkzcoMKDwI8LacyPISak76M=;
        b=NMNCfPYoVD0uSB/sXyDB9x4QlSrWKg6sGcjjX3+N9rBtHwtJZdUqaa4/+qTLeRW94c
         Ni0N0MkWe9T3zSDySkJidIEfv7z9SWA+IDjuuwCNK7+XbNn48Xm/AIjzihl5YsuvmKyx
         MDKUJgogV25nXcy25kzjNObRvLSeg15F6eMpghUvK1LrN3jd9S0YbtzcndudWivtknUs
         pvSKSOCCWOKx/wnZF/C2zn5HJbHTcLMLHjzKigTLbr3Ot+3q/KxTfw9plZgqiwoTGWn+
         RkSBx3Vr2puLYJfd2/jp877n+Vj8aJZPD/homgVbSgUQZYKFTHhiKymR8UK/iVv+9JI2
         UzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792853030; x=1793457830;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buu/u8BY9uW1h69ONwjxYkzcoMKDwI8LacyPISak76M=;
        b=aFvpEAGEoOT4+qhIZ6LXZhPmQV2vjfvSQecp3hLMUkf7Eu/+E4QFETkEzpllh8epkG
         w0/JU4KTpCvbRVVvdHueX6d7JY0/ts9thtHVFpSKkfVFp+4O+7KVpD2HV3yvpsBCuH+D
         Kh+uWZUSUm18jSFHhC5lL2GOD/ziTQRC+PwYIPZkvFP6G8JE3VNfV9Upy3fpvSyRBjgT
         HFNOgMSnF1OlxfEVORcQoNnBPlGDZKO2qxd7/NG/927O/ECIboM/oBVkQgPbhvO0oSVi
         DZVhitZt2VMjm43IoYX6ijcel8D0zMWpFU7Uk5rUzPICpuvgZVtvTeJe/IFDfHPJ2qTo
         5pHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEqNDgTaMKnlvk9L6+F8U41pUvkaP6PGL/dECBajYBzUkfAyPbJ51gppo/FglmqN6hK8vXpznYOGQRw59jyz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf7YXubWut/0+jxDHlc2JUfjqIrtxSjBXHuQHraPFBtWl0awP/
	AOsY2mfRFrtiDaBpZeMlC+/EuDQoc8KHlDf7jpk6O3pmhSSb4vR2pZds1YrbGruytWOBwv0XmG6
	NdWP7IpRAZ1Z0vjKOEQkVVqRz5whGO6Hf6jZorlj/X2St4unWpwRt/r0nWWkQkt4rLbqPrtU=
X-Gm-Gg: AYBFou31Q8YiJCkZSs01ct313cTzxt8tyb0kVMZ4ikji9HuqZOZYV4GOzKqtdR7EMyU
	t+idxO/tPcF5c1lT0Bge1rMiW4ErBCyvLI03VvLYB24gUUlewEyiRtwB5k1j3G4CyMXjoPWy19C
	VncIGAWVNt1gHsnA5Gk+ZHsO86hB60OnzhusaId39fxYn1KstOdhrOQzLm+gQx6YgE1ragddfKS
	Fdey326HfE+O6pTZfyKI39GaYhQaaI6lq5AXNpXnj/9iG+sVKpaAfgfyEnk96rbA9lQgJV0XsMF
	r9ixdnq+rMomRkcnN029y8Lytoy7EgZDEOXw1IUiJ720cmK4fn1vhlPZRyADMjn+DVeb3xKTxdN
	8zTgtlmusFmHCoA==
X-Received: by 2002:a05:7022:7e0b:b0:143:2982:1043 with SMTP id a92af1059eb24-1993639f0f2mr3243300c88.36.1792853029338;
        Sat, 24 Oct 2026 07:43:49 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0b:b0:143:2982:1043 with SMTP id a92af1059eb24-1993639f0f2mr3243237c88.36.1792853028656;
        Sat, 24 Oct 2026 07:43:48 -0700 (PDT)
Received: from [172.31.0.30] ([136.59.194.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm14222976eec.25.2026.10.24.07.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 07:43:48 -0700 (PDT)
Message-ID: <68806dbb-8a7e-46c7-9630-80c60de76a27@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 08:42:32 -0600
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
Subject: Re: [PATCH v17 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
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
 <20261005154039.1464721-7-kees@kernel.org>
 <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>
 <20261010075835.446f27-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffrey.law@oss.qualcomm.com>
In-Reply-To: <20261010075835.446f27-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oEo9771X50lYi13pJFf87lGpIIW6jZFq
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adcc426 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=f0mOnocCY+QlKk/R9FCP2g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OWdUSPwE0GwLUNqlG88A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA1OCBTYWx0ZWRfXyQFY2/a2Fpz6
 Y/S/Mc5Rvz0t0kTZ/bsXSYh47PwKHRiOiiswVJYQDLwgXnXutHZfQG0WM5ktF1Ufgmfx4Y80HKM
 R9lAP6KdPIZ7JuSJ7laXx0suE+iOv8U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA1OCBTYWx0ZWRfX0wNe0wBpP5Uw
 +QorvJGYVP9ivYwmhTuxEFfdSq52ZczFwkk3oCJokdHyI+xMvC35spowqdr995oQqm2vWRAVrOZ
 2Z+eIBfa6BNCiSoGvLoNp/MMJqK4C9xMNF3AeO/ZnFCXdG7fVwRvdABEF+vRTVH0BsGNFvgGTtn
 zPByosnJDqHDoqCQ+u4bwlcbX2S1hJz586+eC6g18l40UTJauhaSi6Z3Z0lrhKw+wPsfr3OXLYz
 7USvfFdcGh3GQYiZA1/5ZplndGH+uXifp8uYNfzdDWhS/VZayOQ6kD/ldAtxLWawQin1wgyDTRZ
 99HsEGOIT07KXvW8tTtfVIciW1gg+dnBEkj9tbUlBJtO5QgtpP9m0StFDdtb6ZAPTUIDSr4E17R
 m9pyWDcbOo6kNNvJXgNDIYcDPDQBat1BXtomt4mAP+BUQti3HDMYkJLGBGWd3DJOX1wQVyEkZ4b
 feNmkGd+UqwlSpvvsxg==
X-Proofpoint-ORIG-GUID: oEo9771X50lYi13pJFf87lGpIIW6jZFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240058



On 10/10/26 2:04 AM, Kees Cook wrote:
>
> You asked this back in v2, and my reply then[1] wasn't very helpful.
> Sorry about that!  Here's hopefully more complete reasoning; v18 will
> also put it in the design comment at the top of kcfi.cc, since you're
> right that it was only asserted there.
>
> 1. The checked target must stay in the checked register until the call.
>     If the register allocator spilled it after the check and reloaded it
>     (or rematerialized it) before the call, memory an attacker can write
>     would supply an unchecked target, effectively restoring the
>     "pop %target; call %target" gadget that KCFI seeks to remove.
>     Separate insns would give reload and the post-reload passes the
>     freedom to create it again, which needs to be avoided.
>
> 2. The trap isn't noreturn. It is designed to be continuable: Linux
>     has a permissive (warn-only) mode where the trap handler reports the
>     mismatch and returns, and execution continues into the call right
>     after it. So the trap can't be gen_trap() with a barrier after it,
>     and the trap block must not be moved out of line by bb-reorder or
>     hot/cold partitioning, even though it looks cold.
>
> 3. The kernel depends on the exact layout. (This is, of course,
>     changeable, but it would require coordination with Linux and Clang.)
>     Specifically on RISC-V, Linux's trap handler (arch/riscv/kernel/cfi.c)
>     reads the beq just before the ebreak to find the register holding the
>     expected type, and the jalr just after it to find the target. On x86,
>     the kernel may rewrite every KCFI call site in place into the FineIBT
>     sequence at boot, patching a fixed number of bytes before the call.
>
> FWIW, Clang KCFI is built the same way: its RISC-V backend emits a
> KCFI_CHECK pseudo that must immediately precede the call through the
> same register (it asserts this), and expands it with specific scratch
> registers when the assembly is printed (RISCVAsmPrinter::LowerKCFI_CHECK).
THanks.  As noted on the other patch.  I'll ponder this, particularly 
#1, that may be what carries the day.
>
>> Why use fixed registers?   It would seem to work better if you just
>> generated pseudos and let the register allocator do the right thing and
>> assign them to whatever temporary is best.  That would also remove the
>> restrictions around -ffixed-reg.
> I'd love to, but the KCFI check is part of/within the call insn and LRA
> allows no output reloads in a CALL_INSN:
>
> 	/* CALL_INSNs are not allowed to have any output reloads.  */
> 	if (CALL_P (curr_insn))
> 	  no_output_reloads_p = true;
>
> So under register pressure the allocator can't provide a scratch register
> for the call pattern, so I had to have each backend instead pick scratch
> registers that are dead at the call (caller-saved temporaries that aren't
> argument registers or the target). I went through this with Andrea for
> AArch64[2][3]. Moving the check out into separate insns, so that pseudos
> would work, runs into point 1 above.
But it'd be an input reload, not an output reload since it's reloading 
for the call address, not the result of the call.  Perhaps if the value 
were needed after the call because we made multiple indirect calls 
through the same pseudo register, the pseudo does not get a hard 
register and the indirect call insns require a call clobbered register 
for the call address -- *maybe*.  But off the top of my head I'd kind of 
expect that to be a series of input reloads rather than a series of 
in/out reloads.




>
> And trying to create an entirely new mode of register allocation for
> use within a CALL_INSN seemed like serious over-kill, given the other
> narrow constraints on KCFI.
Certainly wouldn't suggest that.  Just seems like standard mechanisms 
ought to be working here at least at first glance.

> The atomicity is for the reasons above; the kernel doesn't rewrite the
> ebreak on RISC-V (x86 is where call sites get rewritten).
>
> The directives came from your v12 review[4], where you said that if the
> sequence really must be atomic, it should be wrapped in directives so
> the assembler and linker don't expand macros or relax. However, in
> looking at it more closely now, neither can affect this sequence:
>
> - Nothing in it can be relaxed: the lw is register-relative, the lui and
>    addiw take plain constants with no relocations, the beq goes to a
>    local label, and the jalr is through a register. The linker only
>    relaxes symbol-based sequences marked R_RISCV_RELAX.
>
> - None of the instructions is an assembler macro.
>
> - Compression is harmless: the assembler may use c.lui, c.addiw, c.jalr,
>    or c.ebreak, but the beq can never be compressed (t1 and t2 aren't in
>    the compressed register set, and c.beqz only compares against zero),
>    and the kernel's decoder reads the beq at epc - 4, accepts jalr or
>    c.jalr, and steps over the ebreak by its actual length.
>
> So v18 will drop ".option norelax" and ".option norvc", which also lets
> the sequence shrink with C, and matches Clang, which has none of these
> directives either.
Must have been a mismatch between what I thought you needed and 
reality.  Sorry about the bad steer.


Jeff
