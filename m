Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D134A794
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218357; cv=pass; b=e8nWuIJnnqWAW6ziPHmxrFeOzp8kd4eIn8VppnSYDzGXi+BXLsLFzXjCHwOkK3aunemCuwJHsXFpuXtebX4bWUZNaWJ4tFdVrxt4g80ztjeWhLdf8wAUcC+EHm4TrIv4CEAtZSal4vwkkajI5el6Ga4K0f+M6/UJMgMRbtY3KCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218357; c=relaxed/simple;
	bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=al3uT2bUyuJMSQZJVpXOu3umgUThDqtE4iVL9ry2cVgJ0L6jeREH5Sq9w2/Hm6kjSsF94Dn98VdqOow506ZLz0Dpqg35G9TcLr97cJICCYcpbo+i7ACJ6fSudLVR0cyYJRSKP2EJtptzr2imeRtRwRMsirCFG8JVSv1VTlD930Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asH1tmpu; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asH1tmpu"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso317a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 12:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218354; cv=none;
        d=google.com; s=arc-20240605;
        b=K8MZX88htalEziM/bJf+YzkhuOVqXetlcHB6krzui040OqWVKfBjMUe7Dt4zIwh+Zu
         6KDfl4zMg2dKxFLq+822aSAUVC8S/DK9B+HzZl7CftqlSlayzBpMyN8+mrAIjFVs+gp2
         mEkfEvcjwrrWIcwMniH0dHqc4ugRyMplAaeLSVAs4bZzk14FBZn2r8lBR+pAzkwjnN9b
         5Z95Q2cg9MzmJyFeYQly+JYRqUvufowm1+38AbeKUm+4CfLcdnmmjdFGPVbw60UigBX2
         e/aROopcnFYylQy4ya2hOm3vzVBY+S6i19SDL/kCT0eyWyiAAslnO+KdFpg9F0iTgevU
         bgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        fh=SB6Zf9LdnxDGEzLqK7AtAQGnHnuvLP0RiKIQ48ZWMSU=;
        b=FGeTi9NxPFc+oP7Gb2s4E3tr7jZDWLa3yH2MD57gn0kkgOqZ6KCEqkPwkF2j/mQ5Ry
         PbrOQ3qlP5+dyp3dEH3wo1JjIGykEi7W6PxAYrBRv0p+u9nVFW7ULzP0TW90H/9MTbTT
         /iuWapcSwDJzcwQ0Bg0l60gGxPeAifO7+whG7rZcvCKMpuo61nzsMaaOw/uMBCREYLcj
         S0pem6vy9ogD5ZWcFh2BObu+KLVVdCXroFhPhCWBhTnqA/T0ZPj8kYEbbOJne3u/2OQ2
         vjvEjvh96oGobgJyH26xbmF7hZ7GodFaUW207Czf2xEYmtirFDfHJH3V1fRfHadNN4TM
         ePjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779218354; x=1779823154; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        b=asH1tmpups57VJpaHZMmwrdzGrgkW0SNM23mdQLQ9Ttc07kMwZhzFo1ffRVhOrawM9
         ckoqQmhN2PFrhU0UPQwR7It5iuxwDizvKzdxkKytN1PhE6OoFdXaA2qk0FrS+4ySWzHx
         UuUEOEwuXaLDL2U4G5vjE+bBhbIQofKpO4WvTPw7aWZnWvuOOgRIwejeUUWMpbY5V0e5
         e7emd2RXCDpmWE3K+bCYDzK6RdcJrPKVCFdCjtukN25m/TU0VKeXaW7GuEwl0RIQOTsP
         JYxmbLMrbx4K8C6jHGXxe3B/cAkdqnNO434Y3ghjp5BCWEHz6QuNEjpEnaGD9cVaHFdT
         dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218354; x=1779823154;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYqz98ubw3WV0foWgcnHBs/x8R9g1tkeUZNdNPIzuko=;
        b=icyFSUeSszkkgo6v4LUMJY8/v675WzO+ZBC38fPpOGpJz3UjhbtpEFnHqMnC91etvd
         kQvc+47JHryVjHP+Ke2hSertEEEaitaBr00bwrIdRcMRrajSZncxv0IH6TlvGFc/Wh/a
         /1Mwx/45L1mAPkVJN/Zagotg1jWK8YPnJhv4uiPn6aGr8R5CLMFyD69NVERv+bec7b97
         03T0J7ozn13h8mbp2ht1kKE6aibqMAStwiesweae39wkXmjPjA6NrF2oSm6Ljm7r6yDR
         5hRjPc/RGLN2f3mv7fo5L0/hs1D7LlLnzW233E/i3YR2npy/ocW58SOAQVhZx2RxP9hu
         PCGg==
X-Forwarded-Encrypted: i=1; AFNElJ+B1Rax4/QxW3ct4bTSv7Xr7273kY3G9/KdbOZeaauoTWvfBWIhoxvLb+CCagy5u9ph7Om67APfCukGbz4eXTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfMIjKJNw9Zwbp7B4Vtc+iv2/46WfghbJZ7cYAt28oPjzusji
	eNk02xPXh2TfChhcDThNObYoeIi1QExFJfUwspMsDE8R5As54Faj602plnh4IpEX5znnbiwy8iX
	H2/NZCg5JC0G8W3rNe+BmXBnsFDMF0+nypMPACao0
X-Gm-Gg: Acq92OEvX2JDAmGAGT5jq/9TyiSOpltBwHfMZtG7xmoTbX9+0GUvfEHc8H3qJhd+BH2
	Glm5bpO/AANjZlZY0sShXI8ZqXfhZBkkwujEebh29Q0+IWjf72kKlRw0+2WL3z4QnlTx4SAJyEd
	mWyusLbGmRLSD6bKnzJnI/fbimarRSbB4Us6FcEQjDSsIF3aK6YcIyEp6czePchysMwzYfjsL9P
	D5t04y/+DSM/2y3u10dz331WTMCbGUhjgLz0MHuUuiPYSt0NvwAnPtJ7U3eI7PYFjfEebYxTkig
	Ns6aFYbnGNANP5RTeQU3/wukxYPsPpbRfvsF9y7shq2fh0j9
X-Received: by 2002:a05:6402:104a:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-684891b6cb0mr173665a12.2.1779218353816; Tue, 19 May 2026
 12:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 21:18:37 +0200
X-Gm-Features: AVHnY4IqTfx8C9zgLr9odPC6ok-q4vV_LLekYiqisk-ssm3TXL2pmOtpHKe_o_g
Message-ID: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
Subject: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following is not something I'm planning to work on in the near
future, but I think this would be helpful to allow fuzzers to more
easily detect OOB access bugs in the networking subsystem - maybe
someone else is interested in working on this?

As described in https://docs.kernel.org/networking/skbuff.html , in
the networking subsystem, SKB head buffers are stored with a "struct
skb_shared_info" at the end. This means that out-of-bounds accesses to
SKB data in the head buffer can't be detected by KASAN unless they go
far enough out of bounds to go beyond the skb_shared_info.

For debugging/fuzzing, it might be useful to have a KASAN redzone
somewhere between legitimate data in an SKB and skb_shared_info
metadata, accesses into which would cause KASAN splats. Maybe we could
split sk_buff::end into two separate members for "end of tailroom" and
"start of skb_shared_info" so that a redzone can be placed in between?
Or let debug builds store the skb_shared_info in a separate memory
allocation?

(We could also try to go further and KASAN-poison the headroom and
tailroom until they're actually used, but that might require an
annoying amount of refactoring of existing code, so probably not great
as an initial goal.)
